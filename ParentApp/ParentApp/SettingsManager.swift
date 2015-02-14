//
//  SettingsManager.swift
//  ParentApp
//
//  Created by Jeff Day on 2/14/15.
//  Copyright (c) 2015 JDay Apps, LLC. All rights reserved.
//

import Foundation
import UIKit

/// Responsible for managing current settings made in the Settings app.
class SettingsManager {
    
    /// A singleton instance of the SettingsManager class.
    class var sharedSettingsManager: SettingsManager {
        struct _SharedSettingsManager {
            static let instance = SettingsManager()
        }
        
        return _SharedSettingsManager.instance
    }
    
    
    /// An enum to keep track of keys in the shared NSUserDefaults suite.
    enum AppSettingIdentifier: String {
        case BackgroundColor = "parentAppBackgroundColor"
        
        static let allIdentifiers = [BackgroundColor]
    }
    
    
    /// An enum to keep track of NSNotification names for managed settings.
    enum AppSettingNotification: String {
        case BackgroundColorUpdate = "com.jdayapps.backgroundColorUpdate"
    }
    
    
    
    
    // ---------------------------------------
    // MARK: - Internal Setting Properties
    // ---------------------------------------
    
    /// The background color for `ViewController`.
    var backgroundColor: UIColor?
    
    
    // ---------------------------------------
    // MARK - Private Properties
    // ---------------------------------------
    
    /// An instance of `NSUserDefaults` being shared by apps in this app group.
    private let suiteDefaults: NSUserDefaults = NSUserDefaults(suiteName: APP_GROUP_SUITE)!
    
    
    
    
    
    
    
    /// Iterates through availble settings and updates based on values in the shared NSUserDefaults.
    func checkForSettings() {
        
        for setting in AppSettingIdentifier.allIdentifiers {
            switch setting {
            case .BackgroundColor:
                self.updateBackgroundColor()
            default:
                break
            }
        }
    }
    
    
    
    // ---------------------------------------
    // MARK: - Private Class Methods
    // ---------------------------------------
    
    /**
        Updates the backgroundColor property and sends a notification to `ViewController` in case we are resuming
        from the background.
    */
    private func updateBackgroundColor() {
        
        let key = AppSettingIdentifier.BackgroundColor.rawValue
        
        if let backgroundColorData: NSData = self.suiteDefaults.objectForKey(key) as? NSData {
            if let backgroundColor: UIColor = NSKeyedUnarchiver.unarchiveObjectWithData(backgroundColorData) as? UIColor {
                
                self.backgroundColor = backgroundColor
                
                NSNotificationCenter.defaultCenter().postNotificationName(AppSettingNotification.BackgroundColorUpdate.rawValue,
                    object: nil,
                    userInfo: [key: backgroundColor])
            }
        }
    }
}