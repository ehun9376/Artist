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
        self.window?.rootViewController = RootViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }




}

