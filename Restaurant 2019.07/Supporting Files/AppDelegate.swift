//
//  AppDelegate.swift
//  Restaurant 2019.07
//
//  Created by Denis Bystruev on 05/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var orderTabBarItem: UITabBarItem!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        URLCache.shared = URLCache(memoryCapacity: 25_000_000, diskCapacity: 50_000_000, diskPath: NSTemporaryDirectory())
        
        let tabBarController = window?.rootViewController as? UITabBarController
        orderTabBarItem = tabBarController?.viewControllers?[1].tabBarItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrderBadge), name: MenuController.orderUpdatedNotification, object: nil)
        
        return true
    }
    
    @objc func updateOrderBadge() {
        let count = MenuController.shared.order.menuItems.count
        orderTabBarItem.badgeValue = count == 0 ? nil : String(count)
    }
}

