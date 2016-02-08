//
//  RepositoryModel.swift
//  Demo
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Foundation
import Mapper

struct Repository: Mappable {
    
    let identifier: Int
    let language: String
    let url: String?
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try language = map.from("language")
        url = map.optionalFrom("url")
    }
    
}