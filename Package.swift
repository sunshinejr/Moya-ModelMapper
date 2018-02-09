// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Moya-ModelMapper",
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "11.0.0")),
        .package(url: "https://github.com/lyft/mapper.git", .upToNextMajor(from: "7.0.0")),
    ],
    targets: [
        .target(name: "Moya-ModelMapper", dependencies: ["Moya", "Mapper"]),
        .target(name: "RxMoya-ModelMapper", dependencies: ["RxMoya", "Mapper"]),
        .target(name: "ReactiveMoya-ModelMapper", dependencies: ["ReactiveMoya", "Mapper"])
    ]    
)
