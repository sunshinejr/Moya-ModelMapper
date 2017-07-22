# Moya-ModelMapper
============

[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-ModelMapper.svg)](https://github.com/sunshinejr/Moya-ModelMapper)

[ModelMapper](https://github.com/lyft/mapper) bindings for
[Moya](https://github.com/Moya/Moya) for easier JSON serialization with [RxSwift](https://github.com/ReactiveX/RxSwift) and [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) bindings.

# Installation

## CocoaPods

```
pod 'Moya-ModelMapper', '4.0.0'
```

The subspec if you want to use the bindings over RxSwift.
```
pod 'Moya-ModelMapper/RxSwift', '4.0.0'
```

And the subspec if you want to use the bindings over ReactiveSwift.
```
pod 'Moya-ModelMapper/ReactiveCocoa', '4.0.0'
```

## Carthage

Specify in Cartfile:

```
github "sunshinejr/Moya-ModelMapper"
```

Carthage users can point to this repository and use whichever generated framework they'd like, Moya-ModelMapper, RxMoya-ModelMapper, or ReactiveMoya-ModelMapper.

# Usage

Create a model struct or class. It needs to implement protocol Mappable.

```swift
import Foundation
import Mapper

struct Repository: Mappable {

    let identifier: Int
    let language: String
    let url: String? // Optional property

    init(map: Mapper) throws {
        try identifier = map.from("id")
        try language = map.from("language")
        url = map.optionalFrom("url") // Optional property
    }

}
```

Then you have methods that extends the response from Moya. These methods are:
```swift
mapObject()
mapObject(withKeyPath:)
mapArray()
mapArray(withKeyPath:)
```

While using `mapObject()` tries to map whole response data to object,
with `mapObject(withKeyPath:)` you can specify nested object in a response to
fetch. For example `mapObject(withKeyPath: "data.response.user")` will go through
dictionary of data, through dictionary of response to dictionary of user, which it
will parse. `RxSwift` and `ReactiveCocoa` extensions also have all of the methods,
but `RxSwift` have optional mapping additionally. See examples below, or in a Demo
project.

## 1. Normal usage (without RxSwift or ReactiveCocoa)

```swift
provider = MoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider.request(GitHub.repos("mjacko")) { (result) in
    if case .success(let response) = result {
        do {
            let repos = try response.mapArray() as [Repository]
            print(repos)
        } catch Error.jsonMapping(let error) {
            print(try? error.mapString())
        } catch {
            print(":(")
        }
    }
}
```

## 2. RxSwift
```swift
provider = RxMoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider
    .request(GitHub.repo("Moya/Moya"))
    .mapObject(User.self, keyPath: "owner")
    .subscribe { event in
        switch event {
        case .next(let user):
            print(user)
        case .error(let error):
            print(error)
        default: break
        }
}
```

Additionally, modules for `RxSwift` contains optional mappings. It basically means that if the mapping fails, mapper doesn't throw errors but returns nil. For instance:

```swift
provider = RxMoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider
    .request(GitHub.repos("mjacko"))
    .mapArrayOptional(Repository.self)
    .subscribe { event in
        switch event {
        case .next(let repos):
            // Here we can have either nil or [Repository] object.
            print(repos)
        case .error(let error):
            print(error)
        default: break
        }
}
```


## 3. ReactiveCocoa
```swift
provider = ReactiveCocoaMoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider
    .request(GitHub.repos("mjacko"))
    .mapArray(Repository.self)
    .observeOn(UIScheduler())
    .start { event in
        switch event {
        case .value(let repos):
            print(repos)
        case .failed(let error):
            print(error)
        default: break
        }
}
```

## Author

Sunshinejr, thesunshinejr@gmail.com, <a href="https://twitter.com/thesunshinejr">@thesunshinejr</a>

## License

Moya-ModelMapper is available under the MIT license. See the LICENSE file for more info.
