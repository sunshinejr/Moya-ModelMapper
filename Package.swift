// swift-tools-version:5.0

import PackageDescription
import class Foundation.ProcessInfo

let shouldTest = ProcessInfo.processInfo.environment["TEST_MM"] == "1"

func resolveDependencies() -> [Package.Dependency] {
    let baseDependencies: [Package.Dependency] = [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/lyft/mapper.git", .upToNextMajor(from: "10.0.0"))
    ]

    if shouldTest {
        let testDependencies: [Package.Dependency] = [
            .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.0.0")),
            .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.0"))
        ]

        return baseDependencies + testDependencies
    } else {
        return baseDependencies
    }
}

func resolveTargets() -> [Target] {
    let baseTargets: [Target] = [
        .target(name: "Moya-ModelMapper", dependencies: ["Moya", "Mapper"]),
        .target(name: "RxMoya-ModelMapper", dependencies: ["Moya-ModelMapper", "RxMoya"]),
        .target(name: "ReactiveMoya-ModelMapper", dependencies: ["Moya-ModelMapper", "ReactiveMoya"])
    ]

    if shouldTest {
        let testTargets: [Target] = [
            .testTarget(name: "Moya-ModelMapperTests", dependencies: ["Moya-ModelMapper", "RxMoya-ModelMapper", "ReactiveMoya-ModelMapper", "Quick", "Nimble"])
        ]

        return baseTargets + testTargets
    } else {
        return baseTargets
    }
}

let package = Package(
    name: "Moya-ModelMapper",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "Moya-ModelMapper", targets: ["Moya-ModelMapper"]),
        .library(name: "ReactiveMoya-ModelMapper", targets: ["ReactiveMoya-ModelMapper"]),
        .library(name: "RxMoya-ModelMapper", targets: ["RxMoya-ModelMapper"])
    ],
    dependencies: resolveDependencies(),
    targets: resolveTargets()
)
