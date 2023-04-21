//
//  AppDelegate.swift
//  Artist
//
//  Created by 陳逸煌 on 2023/4/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        application.registerForRemoteNotifications()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: RootViewController()) 
        self.window?.makeKeyAndVisible()
        
        return true
    }
    





}

extension UIApplication {
    func rootViewController() -> UIViewController? {
        if let vc = UIApplication.shared.windows.first?.rootViewController {
            return vc
        } else {
            return nil
        }
    }
}

