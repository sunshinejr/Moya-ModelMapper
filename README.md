# Moya-ModelMapper

[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-ModelMapper.svg)](https://github.com/sunshinejr/Moya-ModelMapper)

[ModelMapper](https://github.com/lyft/mapper) bindings for
[Moya](https://github.com/Moya/Moya) for easier JSON serialization with [RxSwift](https://github.com/ReactiveX/RxSwift) and [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) bindings.

# Installation

## CocoaPods

```
pod 'Moya-ModelMapper', '~> 9.0'
```

The subspec if you want to use the bindings over RxSwift.
```
pod 'Moya-ModelMapper/RxSwift', '~> 9.0'
```

And the subspec if you want to use the bindings over ReactiveSwift.
```
pod 'Moya-ModelMapper/ReactiveSwift', '~> 9.0'
```

## Carthage

Specify in Cartfile:

```
github "sunshinejr/Moya-ModelMapper" ~> 9.0
```

Carthage users can point to this repository and use whichever generated framework they'd like, Moya-ModelMapper, RxMoya-ModelMapper, or ReactiveMoya-ModelMapper.

## Swift Package Manager

Add the following as a dependency to your `Package.swift`.

```swift
.package(url: "https://github.com/sunshinejr/Moya-ModelMapper.git", .upToNextMajor(from: "9.0.0"))
```

The bindings are available through `Moya_ModelMapper` module. If you are interested in reactive extensions, use `ReactiveMoya_ModelMapper` or `RxMoya_ModelMapper` respectively.

# Usage

Create a model struct or class. It needs to implement protocol Mappable.

```swift
import Foundation
import Mapper

struct Repository: Mappable {

    let identifier: Int
    let language: String? // Optional property
    let url: String? // Optional property

    init(map: Mapper) throws {
        try identifier = map.from("id")
        language = map.optionalFrom("language")
        url = map.optionalFrom("url")
    }

}
```

Then you have methods that extends the response from Moya. These methods are:
```swift
map(to:)
map(to:keyPath:)
compactMap(to:)
compactMap(to:keyPath)
```

While using `map(to:)` tries to map whole response data to object/array,
with `map(to:keyPath:)` you can specify nested object in a response to
fetch. For example `map(to: User.self, keyPath: "data.response.user")` will go through
dictionary of data, through dictionary of response to dictionary of user, which it
will parse. `compactMap` is a variant of array `map` that doesn't fail the whole operation
if one of the objects fails, it will just remove the object from the array. 
`RxSwift` and `ReactiveCocoa` extensions also have all of the methods, but `RxSwift` have 
optional mapping additionally. See examples below, or in a Demo project.

## 1. Normal usage (without RxSwift or ReactiveCocoa)

```swift
provider = MoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider.request(GitHub.repos("mjacko")) { (result) in
    if case .success(let response) = result {
        do {
            let repos = try response.map(to: [Repository].self)
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
provider = MoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider.rx.request(GitHub.repo("Moya/Moya"))
    .map(to: User.self, keyPath: "owner")
    .subscribe { event in
        switch event {
        case .success(let user):
            print(user)
        case .error(let error):
            print(error)
        }
}
```

Additionally, modules for `RxSwift` contains optional mappings. It basically means that if the mapping fails, mapper doesn't throw errors but returns nil. For instance:

```swift
provider = MoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider.rx.request(GitHub.repos("mjacko"))
    .mapOptional(to: [Repository].self)
    .subscribe { event in
        switch event {
        case .success(let repos):
            // Here we can have either nil or [Repository] object.
            print(repos)
        case .error(let error):
            print(error)
        }
}
```


## 3. ReactiveSwift
```swift
provider = MoyaProvider<GitHub>(endpointClosure: endpointClosure)
provider.reactive.request(GitHub.repos("mjacko"))
    .map(to: [Repository].self)
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
