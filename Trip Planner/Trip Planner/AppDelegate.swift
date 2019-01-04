//
//  AppDelegate.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else {
            return false
        }
        
        //Set initial viewController
        let params = PlannerParams()
        guard let viewController = PlannerViewController.instantiate(with: params) else {
            return false
        }
        
        let navigationViewController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    
        return true
    }
}

