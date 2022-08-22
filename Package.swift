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
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SwiftUIX", url: "https://github.com/SwiftUIX/SwiftUIX", from: "0.1.1"),
        .package(name: "URLImage", url: "https://github.com/dmytro-anokhin/url-image", from: "3.1.0"),
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect", from: "0.1.3"),
        .package(name: "LoaderUI", url: "https://github.com/Mcrich23/LoaderUI", branch: "master"),
        .package(name: "WKView", url: "https://github.com/rebeloper/WKView", branch: "main"),
        .package(name: "MultiModal", url: "https://github.com/davdroman/MultiModal", from: "2.0.0"),
        .package(name: "SwiftUIMap", url: "https://github.com/Mcrich23/SwiftUIMap", from: "1.1.0"),
        .package(name: "StepperView", url: "https://github.com/badrinathvm/StepperView", branch: "master"),
        .package(name: "SwiftUIBackports", url: "https://github.com/shaps80/SwiftUIBackports", from: "1.6.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Mcrich23-Toolkit",
            dependencies: ["SwiftUIX", "URLImage", "Introspect", "LoaderUI", "WKView", "MultiModal", "SwiftUIMap", "StepperView", "SwiftUIBackports"]
            )
        ]
)
