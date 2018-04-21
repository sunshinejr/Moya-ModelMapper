//
//  Array+Shims.swift
//  Moya-ModelMapper
//
//  Created by Lukasz Mroz on 21.04.2018.
//

#if swift(>=4.1)
#else
extension Collection {
    func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        return try flatMap(transform)
    }
}
#endif
