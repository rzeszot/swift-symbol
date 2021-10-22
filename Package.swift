// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Symbol",
  products: [
    .library(name: "Symbol", targets: ["Symbol"])
  ],
  dependencies: [
    .package(name: "Weak", url: "https://github.com/rzeszot/swift-weak", .exact("1.0.0"))
  ],
  targets: [
    .target(name: "Symbol", dependencies: ["Weak"]),
    .testTarget(name: "SymbolTests", dependencies: ["Symbol"])
  ]
)
