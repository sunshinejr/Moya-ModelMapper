// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Moya-ModelMapper",
    products: [
        .library(name: "Moya-ModelMapper", targets: ["Moya-ModelMapper"]),
        .library(name: "ReactiveMoya-ModelMapper", targets: ["ReactiveMoya-ModelMapper"]),
        .library(name: "RxMoya-ModelMapper", targets: ["RxMoya-ModelMapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .exact("13.0.0-beta.1")),
        .package(url: "https://github.com/lyft/mapper.git", .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.0")),
        .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .target(name: "Moya-ModelMapper", dependencies: ["Moya", "Mapper"]),
        .target(name: "RxMoya-ModelMapper", dependencies: ["Moya-ModelMapper", "RxMoya", "RxSwift", "Mapper"]),
        .target(name: "ReactiveMoya-ModelMapper", dependencies: ["Moya-ModelMapper", "ReactiveMoya", "ReactiveSwift", "Mapper"]),
        .testTarget(name: "Moya-ModelMapperTests", dependencies: ["Moya-ModelMapper", "RxMoya-ModelMapper", "ReactiveMoya-ModelMapper", "Quick", "Nimble", "ReactiveSwift", "RxSwift"])
    ]    
)
