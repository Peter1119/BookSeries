//
//  Project.swift
//  TestApp
//
//  Created by TestDev on 09-11-25.
//  Copyright © 2025 TestDev. All rights reserved.
//

import ProjectDescription

let project = Project(
    name: "BookDetailFeature",
    targets: [
        .target(
            name: "BookDetailFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.testdev.bookdetailfeature",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Domain", path: "../../Domain"),
                .project(target: "DesignSystem", path: "../../DesignSystem")
            ]
        ),
        .target(
            name: "BookDetailFeatureDemo",
            destinations: .iOS,
            product: .app,
            bundleId: "com.testdev.bookdetailfeature.demo",
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
            sources: ["Demo/Sources/**"],
            resources: ["Demo/Resources/**"],
            dependencies: [
                .target(name: "BookDetailFeature")
            ]
        )
    ]
)