//
//  AppDelegate.swift
//  soundCloudTest
//
//  Created by kennyS on 4/24/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let sceneCoordinator = SceneCoordinator(window: window!)
        SceneCoordinator.shared = sceneCoordinator
        sceneCoordinator.transition(to: Scene.splash)
        return true
    }
}
