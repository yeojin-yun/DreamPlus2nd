//
//  AppDelegate.swift
//  Udemy_Bankey
//
//  Created by 순진이 on 2022/08/09.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = OnboardingContainerViewController()
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        dummyViewController.delegate = self
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
//        window?.rootViewController = onboardingViewController
        
        if LocalState.hasOnboarded {
            setViewController(dummyViewController, animated: true)
        } else {
            setViewController(onboardingViewController, animated: true)
        }
    }
}

extension AppDelegate: OnboardingViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setViewController(dummyViewController, animated: true)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setViewController(loginViewController, animated: true)
    }
}

extension AppDelegate {
    func setViewController(_ vc: UIViewController, animated: Bool) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
