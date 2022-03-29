// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mcrich23-Toolkit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Mcrich23-Toolkit",
            targets: ["Mcrich23-Toolkit"]),
    ],
    dependencies: [
        .package(name: "SwiftUIX", url: "https://github.com/SwiftUIX/SwiftUIX", revision: "0.1.2"),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Mcrich23-Toolkit",
            dependencies: []),
    ]
)
