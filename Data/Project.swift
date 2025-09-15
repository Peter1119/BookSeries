import ProjectDescription

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.testdev.data",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain")
            ]
        ),
        .target(
            name: "DataTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.testdev.data.tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: ["Tests/Resources/**"], // 테스트용 리소스 파일들을 번들에 포함
            dependencies: [
                .target(name: "Data")
            ]
        )
    ]
)
