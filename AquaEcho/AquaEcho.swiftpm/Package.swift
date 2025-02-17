// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AquaEcho",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .executable(
            name: "AquaEcho",
            targets: ["AquaEcho"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AquaEcho",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ],
            path: "Sources",
            swiftSettings: [
                .define("SWIFT_PACKAGE")
            ]
        )
    ]
)
    
