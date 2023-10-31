// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EasySwiftExt",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "EasySwiftExt",
            targets: ["EasySwiftExt"]),
        .library(
            name: "EasyUIKitExt",
            targets: ["EasyUIKitExt"]
        )
    ],
    targets: [
        .target(
            name: "EasySwiftExt"),
        .target(
            name: "EasyUIKitExt")
    ]
)
