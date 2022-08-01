//
//  SceneDelegate.swift
//  Type Casting
//
//  Created by 순진이 on 2022/08/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene) // 위에 window가 옵셔널 값이므로
        let homeVC = ViewController()
        let navVC = UINavigationController(rootViewController: homeVC)
        navVC.tabBarItem = UITabBarItem(title: "Players", image: UIImage(systemName: "play.circle"), tag: 0)
        
        let tabBar = UITabBarController()
        let gestureVC = GestureViewController()
        gestureVC.tabBarItem = UITabBarItem(title: "Gesture", image: UIImage(systemName: "hand.point.up.left"), tag: 1)
        
        tabBar.viewControllers = [navVC, gestureVC]
        homeVC.navigationItem.title = "Players"
        window?.rootViewController = tabBar
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}

