// swift-tools-version:6.0.2

import PackageDescription

let package = Package(
  name: "aoc",

  products: [
    .executable(
      name: "aoc",
      targets: ["aoc"])
  ],

  dependencies: [
    .package(url: "https://github.com/apple/swift-system", from: "1.4.0"),
  ],
  
  targets: [
    .executableTarget(
      name: "aoc",
      dependencies: [
        .product(name: "SystemPackage", package: "swift-system"),
      ],
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]),
  ]
)
