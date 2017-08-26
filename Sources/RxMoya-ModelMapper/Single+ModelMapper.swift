//
//  Single+ModelMapper.swift
//  Pods
//
//  Created by sunshinejr on 26.08.2017.
//  Copyright © 2017 sunshinejr. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Mapper
#if !COCOAPODS
    import Moya_ModelMapper
#endif

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {

    /// Maps data received from the signal into an object (on the default Background thread) which
    /// implements the Mappable protocol and returns the result back on the MainScheduler.
    /// If the conversion fails, the signal errors.
    public func map<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Single<T> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { response -> Single<T> in
                return Single.just(try response.map(to: type, keyPath: keyPath))
            }
            .observeOn(MainScheduler.instance)
    }

    /// Maps data received from the signal into an array of objects (on the default Background thread)
    /// which implement the Mappable protocol and returns the result back on the MainScheduler
    /// If the conversion fails, the signal errors.
    public func map<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Single<[T]> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { response -> Single<[T]> in
                return Single.just(try response.map(to: type, keyPath: keyPath))
            }
            .observeOn(MainScheduler.instance)
    }

    /// Maps data received from the signal into an object (on the default Background thread) which
    /// implements the Mappable protocol and returns the result back on the MainScheduler.
    /// If the conversion fails, the nil is returned instead of error signal.
    public func mapOptional<T: Mappable>(to type: T.Type, keyPath: String? = nil) -> Single<T?> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { response -> Single<T?> in
                do {
                    let object = try response.map(to: type, keyPath: keyPath)
                    return Single.just(object)
                } catch {
                    return Single.just(nil)
                }

            }
            .observeOn(MainScheduler.instance)
    }

    /// Maps data received from the signal into an array of objects (on the default Background thread)
    /// which implement the Mappable protocol and returns the result back on the MainScheduler
    /// If the conversion fails, the nil is returned instead of error signal.
    public func mapOptional<T: Mappable>(to type: [T].Type, keyPath: String? = nil) -> Single<[T]?> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { response -> Single<[T]?> in
                do {
                    let object = try response.map(to: type, keyPath: keyPath)
                    return Single.just(object)
                } catch {
                    return Single.just(nil)
                }
            }
            .observeOn(MainScheduler.instance)
    }
}
