// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AquaEcho",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "AquaEcho",
            targets: ["AquaEcho"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-charts.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "AquaEcho",
            dependencies: [
                .product(name: "Charts", package: "swift-charts")
            ],
            path: "Sources"
        )
    ]
)
