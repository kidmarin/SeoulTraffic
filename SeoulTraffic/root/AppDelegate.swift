//
//  AppDelegate.swift
//  SeoulTraffic
//
//  Created by 강 성민 on 2017. 7. 7..
//  Copyright © 2017년 AppSpace All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    weak var mainVC: MainTabController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let mainVC = MainTabController()
        let national = MapViewController()
        let express = MapViewController()
        let namsan = MapViewController()
        national.mapDetails = MapDetails.nationalMap()
        express.mapDetails = MapDetails.expressMap()
        namsan.mapDetails = MapDetails.namsanMap()
        
        national.tabBarItem = UITabBarItem(title: "일반도로", image: UIImage(named: "icSudo"), selectedImage: nil)
        express.tabBarItem = UITabBarItem(title: "고속도로", image: UIImage(named: "icExpress"), selectedImage: nil)
        namsan.tabBarItem = UITabBarItem(title: "남산", image: UIImage(named: "icNamsan"), selectedImage: nil)
        
        mainVC.viewControllers = [national, express, namsan]
        mainVC.selectedIndex = UserDefaults.standard.integer(forKey: "lastTabIndex")

        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        self.mainVC = mainVC
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        mainVC?.stopTimer()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        mainVC?.refreshCurrentMap()
        mainVC?.startTimer()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

