// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSFML",
    products: [
        .library(name: "SwiftSFML", targets: ["SwiftSFML"]),
        .executable(name: "SwiftSFMLApp", targets: ["SwiftSFMLApp"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftSFML",
            dependencies: ["CSFML"]),
        .systemLibrary(name:"CSFML",
                providers: [ .apt(["libcsfml-dev"]), .brew(["csfml"])]),
        .testTarget(
            name: "SwiftSFMLTests",
            dependencies: ["SwiftSFML"]),
        .target(
            name: "SwiftSFMLApp",
            dependencies: ["SwiftSFML"],
                resources: [
                    .copy("Resources/")
                ]),
    ]
)
