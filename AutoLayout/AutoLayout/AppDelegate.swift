//
//  AppDelegate.swift
//  AutoLayout
//
//  Created by 순진이 on 2022/08/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // sceneDelegate를 지우는 이유?
        // split View를 지원하게 되면서 각 화면을 window로 나누게 됨
        // 그 이전에는 AppDelegate만 있었지만 그 이후에는 SceneDelegate로 나눠진다.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        
        return true
    }

}

