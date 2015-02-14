//
//  ViewController.swift
//  ParentApp
//
//  Created by Jeff Day on 2/14/15.
//  Copyright (c) 2015 JDay Apps, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "updateBackgroundColorFromNotification:",
            name: SettingsManager.AppSettingNotification.BackgroundColorUpdate.rawValue,
            object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let backgroundColor: UIColor = SettingsManager.sharedSettingsManager.backgroundColor {
            self.updateBackgroundColor(backgroundColor)
        }
    }
    
    
    
    
    private func updateBackgroundColor(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    private func updateBackgroundColorFromNotification(notification: NSNotification) {
        if let backgroundColor: UIColor = notification.userInfo?[SettingsManager.AppSettingIdentifier.BackgroundColor.rawValue] as? UIColor {
            self.updateBackgroundColor(backgroundColor)
        }
    }
    
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: SettingsManager.AppSettingNotification.BackgroundColorUpdate.rawValue,
            object: nil)
    }
}