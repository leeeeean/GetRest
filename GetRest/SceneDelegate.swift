//
//  SceneDelegate.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }


}

