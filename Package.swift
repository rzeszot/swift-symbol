// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Symbol",
  products: [
    .library(name: "Symbol", targets: ["Symbol"])
  ],
  targets: [
    .target(name: "Symbol"),
    .testTarget(name: "SymbolTests", dependencies: ["Symbol"])
  ]
)
