// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "OpenCombine",
  products: [
    .library(name: "OpenCombine", targets: ["OpenCombine"]),
    .library(name: "OpenCombineDispatch", targets: ["OpenCombineDispatch"]),
    .library(name: "OpenCombineFoundation", targets: ["OpenCombineFoundation"]),
  ],
  targets: [
    .target(name: "COpenCombineHelpers"),
    .target(
      name: "OpenCombine",
      dependencies: [
        .target(name: "COpenCombineHelpers", condition: .when(platforms: [.macOS, .linux, .iOS])),
      ],
      exclude: [
        "Publishers/Publishers.Encode.swift.gyb",
        "Publishers/Publishers.Catch.swift.gyb",
        "Publishers/Publishers.MapKeyPath.swift.gyb",
      ]
    ),
    .target(name: "OpenCombineDispatch", dependencies: ["OpenCombine"]),
    .target(name: "OpenCombineFoundation", dependencies: ["OpenCombine",
                                                          "COpenCombineHelpers"]),
    .testTarget(name: "OpenCombineTests",
                dependencies: ["OpenCombine",
                               "OpenCombineDispatch",
                               "OpenCombineFoundation"],
                swiftSettings: [.unsafeFlags(["-enable-testing"])]),
  ],
  cxxLanguageStandard: .cxx1z
)
