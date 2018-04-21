import Foundation
import RxSwift
import Moya
import Mapper
#if !COCOAPODS
    import Moya_ModelMapper
#endif

public extension ObservableType where E == Response {

    @available(*, unavailable, renamed: "map(to:keyPath:)")
    public func mapObject<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<T> { fatalError() }

    @available(*, unavailable, renamed: "map(to:keyPath:)")
    public func mapArray<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<[T]> { fatalError() }

    @available(*, unavailable, renamed: "mapOptional(to:keyPath:)")
    public func mapObjectOptional<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<T?> { fatalError() }

    @available(*, unavailable, renamed: "mapOptional(to:keyPath:)")
    public func mapArrayOptional<T: Mappable>(type: T.Type, keyPath: String? = nil) -> Observable<[T]?> { fatalError() }
}

