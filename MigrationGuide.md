# Migration Guide

This project follows [Semantic Versioning](http://semver.org).

Please follow the appropriate guide below when **upgrading to a new major version** of Moya-ModelMapper (e.g. 5.0 -> 6.0).

## Upgrade from 5.x to 6.x
First of all please check [Moya's Migration Guide from 9.* to 10.*](https://github.com/Moya/Moya/blob/10.0.0-dev/docs/MigrationGuides/migration_9_to_10.md) as there are few changes. (Especially change in CocoaPods from `Moya/ReactiveCocoa` to `Moya/ReactiveSwift`)

In `Moya-ModelMapper` we have one really big change for `Moya-ModelMapper/RxSwift` users. Now we don't observe on background scheduler and then return response on main scheduler - it is completely up to you how you wanna do it right now. See [issue#26](https://github.com/sunshinejr/Moya-ModelMapper/issues/26) for more info. If you want to bring back the behavior that was in `Moya-ModelMapper` 5.0, you would do something like the following. 

Instead of:
```swift
provider.request(.Repos)
    .map(to: [Repo].self)
```

you would do:
```swift
observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    .flatMap { response -> Observable<T> in
        provider.request(.Repos)
            .map(to: [Repo].self)
    }
    .observeOn(MainScheduler.instance)
```