// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Moya-ModelMapper",
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .exact("10.0.0-beta.1")),
        .package(url: "https://github.com/lyft/mapper.git", .upToNextMajor(from: "7.0.0")),
    ],
    targets: [
        .target(name: "Moya-ModelMapper", dependencies: ["Moya", "Mapper"]),
        .target(name: "RxMoya-ModelMapper", dependencies: ["Moya-ModelMapper"]),
        .target(name: "ReactiveMoya-ModelMapper", dependencies: ["Moya-ModelMapper"])
    ]    
)
