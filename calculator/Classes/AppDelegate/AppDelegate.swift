//
//  AppDelegate.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let atm = ATM()
        atm.refillCash()
//        atm.withdraw(requestedSum: 30, requiresSmallBanknotes: true)
        atm.withdraw(requestedSum: 455, requiresSmallBanknotes: false)
        atm.deposit(banknotes: [Banknote(.fifty, 51), Banknote(.twenty, 1), Banknote(.twoHundred, 15)])
        atm.withdraw(requestedSum: 40, requiresSmallBanknotes: true)
//        atm.deposit(banknotes: [Banknote(.twoHundred, 10)])
//        atm.withdraw(requestedSum: 255, requiresSmallBanknotes: false)
        // Override point for customization after application launch.
//        atm.refillCash()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

