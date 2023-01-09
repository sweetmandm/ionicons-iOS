// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "IonIcons",
    products: [
        .library(name: "IonIcons", targets: ["IonIcons"]),
        .library(name: "IonIconsSwift", targets: ["IonIconsSwift"]),
    ],
    targets: [
        .target(
            name: "IonIcons",
            path: "ionicons/",
            sources: [
                "FontInspector.h",
                "FontInspector.m",
                "ionicons-codes.h",
                "IonIcons-iOS.h",
                "IonIcons-iOS.m",
            ],
            resources: [
                .process("ionicons.ttf"),
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "IonIconsSwift",
            dependencies: [
                "IonIcons"
            ]
        ),
    ]
)
