//
//  Response+ModelMapper.swift
//  Pods
//
//  Created by sunshinejr on 02.02.2016.
//  Copyright © 2016 sunshinejr. All rights reserved.
//

import Foundation
import Moya
import Mapper

public extension Response {
    
    /// Parse json (in ModelMapper it should be NSDictionary) to an object
    public func mapObject<T: Mappable>() throws -> T {
        guard let jsonDictionary = try mapJSON() as? NSDictionary, object = T.from(jsonDictionary) else {
            throw Error.JSONMapping(self)
        }
        return object
    }
    
    /// Since 1.0.3 version of ModelMapper is not out in cocoapods,
    /// we have to manually parse arrays
    public func mapArray<T: Mappable>() throws -> [T] {
        guard let jsonArray = try mapJSON() as? NSArray else {
            throw Error.JSONMapping(self)
        }

        var returnArray = [T]()
        for dict in jsonArray {
            if let dict = dict as? NSDictionary, object = T.from(dict) {
                returnArray.append(object)
            }
        }
        return returnArray
    }
}