//
//  UserModel.swift
//  Demo
//
//  Created by Lukasz Mroz on 03.04.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Mapper

struct User: Mappable {
    
    let login: String
    
    init(map: Mapper) throws {
        try login = map.from("login")
    }
}