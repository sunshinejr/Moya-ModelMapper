import Foundation
import RxSwift
import Moya
import Mapper
#if !COCOAPODS
    import Moya_ModelMapper
#endif

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where E == Response {

    /// Maps data received from the signal into an object which implement the Mappable protocol
    /// If the conversion fails, error event is sent.
    public func map<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
                return Observable.just(try response.map(to: type, keyPath: keyPath))
            }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, the error event is sent.
    /// If you want to remove the object from an array on error, use `compactMap()` instead.
    public func map<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
                return Observable.just(try response.map(to: type, keyPath: keyPath))
            }
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, it's removed from the response array.
    /// If you want to throw an error on any failure, use `map()` instead.
    public func compactMap<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.compactMap(to: type, keyPath: keyPath))
        }
    }

    /// Maps data received from the signal into an object which implement the Mappable protocol.
    /// If the conversion fails, the nil is returned instead of error signal.
    public func mapOptional<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Observable<T?> {
        return flatMap { response -> Observable<T?> in
                do {
                    let object = try response.map(to: type, keyPath: keyPath)
                    return Observable.just(object)
                } catch {
                    return Observable.just(nil)
                }   
            }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails, the nil is returned instead of error signal.
    public func mapOptional<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]?> {
        return flatMap { response -> Observable<[T]?> in
                do {
                    let object = try response.map(to: type, keyPath: keyPath)
                    return Observable.just(object)
                } catch {
                    return Observable.just(nil)
                }
            }
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails at any object, it's removed from the response array.
    /// If the whole conversion fails, the nil is returned instead of error signal.
    /// Please see `map` and `compactMap` for other solutions to this problem.
    public func compactMapOptional<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Observable<[T]?> {
        return flatMap { response -> Observable<[T]?> in
            do {
                let object = try response.compactMap(to: type, keyPath: keyPath)
                return Observable.just(object)
            } catch {
                return Observable.just(nil)
            }
        }
    }
}
