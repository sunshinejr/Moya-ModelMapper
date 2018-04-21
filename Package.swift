// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Moya-ModelMapper",
    products: [
        .library(name: "Moya-ModelMapper", targets: ["Moya-ModelMapper"]),
        .library(name: "ReactiveMoya-ModelMapper", targets: ["ReactiveMoya-ModelMapper"]),
        .library(name: "RxMoya-ModelMapper", targets: ["RxMoya-ModelMapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "11.0.0")),
        .package(url: "https://github.com/lyft/mapper.git", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.3"))
    ],
    targets: [
        .target(name: "Moya-ModelMapper", dependencies: ["Moya", "Mapper"]),
        .target(name: "RxMoya-ModelMapper", dependencies: ["RxMoya", "Mapper"]),
        .target(name: "ReactiveMoya-ModelMapper", dependencies: ["ReactiveMoya", "Mapper"]),
        .testTarget(name: "Moya-ModelMapperTests", dependencies: ["Moya-ModelMapper", "Quick", "Nimble"])
    ]    
)
