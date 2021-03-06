//
//  AppDelegate.swift
//  ParentApp
//
//  Created by Jeff Day on 2/14/15.
//  Copyright (c) 2015 JDay Apps, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // get latest settings
        SettingsManager.sharedSettingsManager.checkForSettings()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
        // get latest settings
        SettingsManager.sharedSettingsManager.checkForSettings()
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

