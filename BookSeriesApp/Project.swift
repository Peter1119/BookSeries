import ProjectDescription

let project = Project(
    name: "BookSeriesApp",
    targets: [
        .target(
            name: "BookSeriesApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.testdev.bookseriesapp",
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen",
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                    "UISceneConfigurations": [
                        "UIWindowSceneSessionRoleApplication": [
                            [
                                "UISceneConfigurationName": "Default Configuration",
                                "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                            ]
                        ]
                    ]
                ]
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "BookDetailFeature", path: "../Feature/BookDetail")
            ]
        )
    ]
)
