//
//  SceneDelegate.swift
//  TestApp
//
//  Created by TestDev on 09-11-25.
//  Copyright © 2025 TestDev. All rights reserved.
//

import UIKit
import BookDetailFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = BookDetailViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}