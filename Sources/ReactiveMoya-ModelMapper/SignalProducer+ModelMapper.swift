import ReactiveSwift
import Moya
import Mapper
#if !COCOAPODS
    import Moya_ModelMapper
#endif

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension SignalProducerProtocol where Value == Moya.Response, Error == MoyaError {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> SignalProducer<T, MoyaError> {
        return producer.flatMap(.latest) { response -> SignalProducer<T, Error> in
            return unwrapThrowable { try response.map(to: type, keyPath: keyPath) }
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails at any object, the error event is sent. If you want to remove the object
    /// from an array on error, use `compactMap()` instead.
    public func map<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> SignalProducer<[T], MoyaError> {
        return producer.flatMap(.latest) { response -> SignalProducer<[T], Error> in
            return unwrapThrowable { try response.map(to: type, keyPath: keyPath) }
        }
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails at any object, it's removed from the response array. If you want to throw
    /// an error on any failure, use `map()` instead.
    public func compactMap<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> SignalProducer<[T], MoyaError> {
        return producer.flatMap(.latest) { response -> SignalProducer<[T], Error> in
            return unwrapThrowable { try response.compactMap(to: type, keyPath: keyPath) }
        }
    }
}

/// Maps throwable to SignalProducer
private func unwrapThrowable<T>(throwable: () throws -> T) -> SignalProducer<T, MoyaError> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        return SignalProducer(error: error as! MoyaError)
    }
}
