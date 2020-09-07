// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MGLoadMore",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "MGLoadMore",
            targets: ["MGLoadMore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.0"),
        .package(url: "https://github.com/eggswift/pull-to-refresh", from: "2.9.3"),
    ],
    targets: [
        .target(
            name: "MGLoadMore",
            dependencies: [
                .product(name: "ESPullToRefresh"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
            ],
            path: "MGLoadMore/Sources"
        ),    
    ],
    swiftLanguageVersions: [.v5]
)
