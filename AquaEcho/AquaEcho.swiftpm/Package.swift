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
    targets: [
        .executableTarget(
            name: "AquaEcho",
            path: "Sources"
        )
    ]
)