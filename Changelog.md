# Next

# 7.1.0
- Added `compactMap` as a variation of mapping an array that doesn't fail when one of the objects fails

# 7.0.2
- Fixed a bug that Single extensions still had observing on schedulers that Observable extensions had removed in Moya-ModelMapper 6.0.

# 7.0.1 (Carthage only)
- Fixed a bug that Carthage would consume unnecessary second xcodeproj.

# 7.0.0
- Fixed SPM integration for reactive providers.
- Moya updated to 11.0.0

# 6.0.0
- Moya updated to 10.0.0

# 6.0.0-beta.1
- **Breaking change** Removed observing schedulers from mapping. Take a look at [MigrationGuide.md](https://github.com/sunshinejr/Moya-ModelMapper/blob/master/MigrationGuide.md).
- Moya updated to 10.0.0-beta.1
- SPM updated to SPMv4
- Carthage support for tvOS, macOS and watchOS

# 5.0.0
- Moya updated to 9.0.0

# 5.0.0-beta.1
- Renamed methods from `mapObject`, `mapArray` to `map(to:keyPath:)`.
- Renamed RxSwift extensions method to `map(to:keyPath:)` as well.
- Updated Moya to 9.0.0-beta.1.
- Added `Single<Response>` extensions to RxSwift so Moya 9.0 feels right in usage.
- Renamed CocoaPods subspec from `Moya-ModelMapper/ReactiveCocoa` to `Moya-ModelMapper/ReactiveSwift`. However, the former one will still work for some time as well.

# 4.1.0
- Update iOS min deploment to 8.0 and macOS to 10.10

# 4.0.0
- Moya updated to 8.0.0
- ReactiveSwift updated to 1.0.0

# 4.0.0-beta.4
- Moya updated to 8.0.0-beta.5
- ReactiveSwift updated to 1.0.0-alpha.4

# 4.0.0-beta.3
- Moya updated to 8.0.0-beta.4
- RxSwift updated to ~> 3.0.0

# 4.0.0-beta.2
- Moya updated to 8.0.0-beta.3
- RxSwift updated to 3.0.0-rc.1
- ReactiveSwift updated to 1.0.0-alpha.3

# 4.0.0-beta.1
- Swift updated to 3.0 (this version supports only Swift 3.0)
- Moya updated to 8.0.0-beta.2
- RxSwift updated to 3.0.0-beta.2
- ReactiveSwift updated to 1.0.0-alpha.2

# 3.0.0
- Moya updated to 7.0.

# 2.0.1
- Fix bug without with mapping without keyPath.

# 2.0.0
- Add `mapObject(withKeyPath:)` and `mapArray(withKeyPath:)` methods.
- Add `mapObject(:keyPath:)`, `mapArray(:keyPath:)` to `RxSwift` and `ReactiveCocoa` extensions.
- Use native mapping with array, instead of custom, thanks to Mapper update.
- Update to `Moya` 6.4, `ReactiveCocoa` 4.1, `RxSwift` 2.3 and `Mapper` 2.0.

# 1.4.0
- Optional map methods added. `mapObjectOptional()` and `mapArrayOptional()` to RxSwift.

# 1.3.0
- CocoaPods update.

# 1.2.0
- Dependencies update for Carthage.

# 1.1.2
- Carthage compatibility added.

# 1.1.0
- Demo added.

# 1.0.0
- Initial release. 🎉
