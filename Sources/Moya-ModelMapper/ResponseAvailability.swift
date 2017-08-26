//
//  ResponseAvailability.swift
//  Pods
//
//  Created by sunshinejr on 26.08.2017.
//  Copyright © 2017 sunshinejr. All rights reserved.
//

import Foundation
import Moya
import Mapper

public extension Response {

    @available(*, unavailable, renamed: "map(to:)")
    public func mapObject<T: Mappable>() throws -> T { fatalError() }

    @available(*, unavailable, renamed: "map(to:keyPath:)")
    public func mapObject<T: Mappable>(withKeyPath keyPath: String?) throws -> T { fatalError() }

    @available(*, unavailable, renamed: "map(to:)")
    public func mapArray<T: Mappable>() throws -> [T] { fatalError() }

    @available(*, unavailable, renamed: "map(to:keyPath:)")
    public func mapArray<T: Mappable>(withKeyPath keyPath: String?) throws -> [T] { fatalError() }
}
