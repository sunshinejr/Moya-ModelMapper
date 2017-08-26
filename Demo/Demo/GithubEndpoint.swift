//
//  GithubEndpoint.swift
//  Demo
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum GitHub {
    case zen
    case userProfile(String)
    case repos(String)
    case repo(String)
}

extension GitHub: TargetType {

    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var method: Moya.Method { return .get }
    var headers: [String : String]? { return nil }
    var task: Task { return .requestPlain }

    var path: String {
        switch self {
        case .repos(let name):
            return "/users/\(name.URLEscapedString)/repos"
        case .zen:
            return "/zen"
        case .userProfile(let name):
            return "/users/\(name.URLEscapedString)"
        case .repo(let name):
            return "/repos/\(name)"
        }
    }
    
    var sampleData: Data {
        switch self {
        case .repos(_):
            return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\"}}".data(using: String.Encoding.utf8)!
        case .zen:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .userProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .repo(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: String.Encoding.utf8)!
        }
    }
}
