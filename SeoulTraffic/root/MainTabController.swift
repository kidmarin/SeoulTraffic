//
//  MainTabController.swift
//  SeoulTraffic
//
//  Created by 강 성민 on 2017. 7. 7..
//  Copyright © 2017년 AppSpace All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    var timer: Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        selectedViewController?.viewDidAppear(animated)
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UserDefaults.standard.set(selectedIndex, forKey: "lastTabIndex")
        UserDefaults.standard.synchronize()
        refreshCurrentMap()
        stopTimer()
        startTimer()
    }
    
    // MARK: Public Methods
    internal func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 90, target: self, selector: #selector(refreshCurrentMap), userInfo: nil, repeats: true)
    }
    
    internal func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc internal func refreshCurrentMap() {
        guard let mapViewController: MapViewController = selectedViewController as? MapViewController else {
            return
        }
        mapViewController.refreshMapImage()
        mapViewController.refreshRoadImage()
    }
}
