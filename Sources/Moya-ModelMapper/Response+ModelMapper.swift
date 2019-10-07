import Foundation
import Moya
import Mapper

public extension Response {

    func map<T: Mappable>(to type: T.Type) throws -> T {
        guard let jsonDictionary = try mapJSON() as? NSDictionary else {
            throw MoyaError.jsonMapping(self)
        }

        do {
            return try T(map: Mapper(JSON: jsonDictionary))
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }
    
    func map<T: Mappable>(to type: T.Type, keyPath: String?) throws -> T {
        guard let keyPath = keyPath else { return try map(to: type) }
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
            let objectDictionary = jsonDictionary.value(forKeyPath:keyPath) as? NSDictionary else {
                throw MoyaError.jsonMapping(self)
        }

        do {
            return try T(map: Mapper(JSON: objectDictionary))
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }
    
    func map<T: Mappable>(to type: [T].Type) throws -> [T] {
        guard let jsonArray = try mapJSON() as? [NSDictionary] else {
            throw MoyaError.jsonMapping(self)
        }

        do {
            return try jsonArray.map { try T(map: Mapper(JSON: $0)) }
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }

    func compactMap<T: Mappable>(to type: [T].Type) throws -> [T] {
        guard let jsonArray = try mapJSON() as? [NSDictionary] else {
            throw MoyaError.jsonMapping(self)
        }

        return jsonArray.compactMap { try? T(map: Mapper(JSON: $0)) }
    }
    
    func map<T: Mappable>(to type: [T].Type, keyPath: String?) throws -> [T] {
        guard let keyPath = keyPath else { return try map(to: type) }
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
            let objectArray = jsonDictionary.value(forKeyPath:keyPath) as? [NSDictionary] else {
                throw MoyaError.jsonMapping(self)
        }

        do {
            return try objectArray.map { try T(map: Mapper(JSON: $0)) }
        } catch {
            throw MoyaError.underlying(error, self)
        }
    }

    func compactMap<T: Mappable>(to type: [T].Type, keyPath: String?) throws -> [T] {
        guard let keyPath = keyPath else { return try compactMap(to: type) }

        guard let jsonDictionary = try mapJSON() as? NSDictionary,
            let objectArray = jsonDictionary.value(forKeyPath:keyPath) as? [NSDictionary] else {
                throw MoyaError.jsonMapping(self)
        }

        return objectArray.compactMap { try? T(map: Mapper(JSON: $0)) }
    }
}
