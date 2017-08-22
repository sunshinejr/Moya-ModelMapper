// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Moya-ModelMapper",
    targets: [
        Target(name: "Moya-ModelMapper"),
        Target(name: "RxMoya-ModelMapper", dependencies: ["Moya-ModelMapper"]),
        Target(name: "ReactiveMoya-ModelMapper", dependencies: ["Moya-ModelMapper"])
    ],
    dependencies: [
        .Package(url: "https://github.com/Moya/Moya", majorVersion: 8),
        .Package(url: "https://github.com/lyft/mapper", majorVersion: 6),
    ]
)
