// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CL_",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Data", targets: ["Data"]),
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Presentation", targets: ["Presentation"])
    ],
    targets: [
        .target(name: "Common",
                path: "Common/Common"),
        .testTarget(name: "CommonTests",
                    dependencies: [
                        .target(name: "Common")
                    ],
                    path: "Common/Tests"),
        .target(name: "Network",
                dependencies: [
                    .target(name: "Common"),
                    .target(name: "Domain")
                ],
                path: "Network/Network"),
        .testTarget(name: "NetworkTests",
                    dependencies: [
                        .target(name: "Network")
                    ],
                    path: "Network/Tests"),
        
        //MARK: Domain
        .target(name: "Domain",
                path: "Domain/Domain"),
        .testTarget(name: "DomainTests",
                    dependencies: [
                        .target(name: "Domain")
                    ],
                    path: "Domain/Tests"),
        
        //MARK: Data
        .target(name: "Data",
                dependencies: [
                    .target(name: "Common"),
                    .target(name: "Domain"),
                    .target(name: "Network")
                ],
                path: "Data/Data"),
        .testTarget(name: "DataTests",
                    dependencies: [
                        .target(name: "Data")
                    ],
                    path: "Data/Tests"),
        
        //MARK: Presentation
        .target(name: "Presentation",
                dependencies: [
                    .target(name: "Common"),
                    .target(name: "Domain")
                ],
                path: "Presentation/Presentation"),
        .testTarget(name: "PresentationTests",
                    dependencies: [
                        .target(name: "Presentation")
                    ],
                    path: "Presentation/Tests")
    ]
)
