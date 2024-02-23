//
//  SceneDelegate.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 23/2/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let splashVC = SplashVC()
        let navigationController = UINavigationController(rootViewController: splashVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

