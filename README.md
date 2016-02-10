# Moya-ModelMapper
============

[![CocoaPods](https://img.shields.io/cocoapods/v/Moya-ModelMapper.svg)](https://github.com/sunshinejr/Moya-ModelMapper)

[ModelMapper](https://github.com/lyft/mapper) bindings for
[Moya](https://github.com/Moya/Moya) for easier JSON serialization with [RxSwift](https://github.com/ReactiveX/RxSwift) and [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) bindings.

# Installation

## CocoaPods

`pod 'Moya-ModelMapper', '~> 1.0.0'`

The subspec if you want to use the bindings over RxSwift.

`pod 'Moya-ModelMapper/RxSwift', '~> 1.0.0'`

And the subspec if you want to use the bindings over ReactiveCocoa.

`pod 'Moya-ModelMapper/ReactiveCocoa', '~> 1.0.0'`

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

## 1. Normal usage (without RxSwift or ReactiveCocoa)

```swift
provider = MoyaProvider(endpointClosure: endpointClosure)
provider.request(GitHub.Repos("mjacko")) { (result) in
    if case .Success(let response) = result {
        do {
            let repos = try response.mapArray() as [Repository]
            print(repos)
        } catch Error.JSONMapping(let error) {
            print(try? error.mapString())
        } catch {
            print(":(")
        }
    }
}
```

## 2. RxSwift
```swift
provider = RxMoyaProvider(endpointClosure: endpointClosure)
provider
    .request(GitHub.Repos("mjacko"))
    .mapArray(Repository.self)
    .subscribe { event in
        switch event {
        case .Next(let repos):
            print(repos)
        case .Error(let error):
            print(error)
        default: break
        }
}
```


## 3. ReactiveCocoa
```swift
provider = ReactiveCocoaMoyaProvider(endpointClosure: endpointClosure)
provider
    .request(GitHub.Repos("mjacko"))
    .mapArray(Repository.self)
    .observeOn(UIScheduler())
    .start { event in
        switch event {
        case .Next(let repos):
            print(repos)
        case .Failed(let error):
            print(error)
        default: break
        }
}
```

## Author

Sunshinejr, thesunshinejr@gmail.com

## License

Moya-ModelMapper is available under the MIT license. See the LICENSE file for more info.
