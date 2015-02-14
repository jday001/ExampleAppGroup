//
//  ViewController.swift
//  SettingsApp
//
//  Created by Jeff Day on 2/14/15.
//  Copyright (c) 2015 JDay Apps, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let APP_GROUP_SUITE: String = "group.com.jdayapps.examplegroup"
    let BACKGROUND_COLOR: String = "parentAppBackgroundColor"
    let SELECTED_SEGMENT: String = "backgroundColorSelectedSegmentIndex"
    
    @IBOutlet weak var backgroundColorControl: UISegmentedControl!
    
    
    /// Associates index values in the segmentedControl with corresponding colors.
    enum BackgroundColorIndex: Int {
        case Black = 0, Blue, Red
        
        init(_ index: Int) {
            switch index {
            case 0:     self = .Black
            case 1:     self = .Blue
            default:    self = .Red
            }
        }
        
        func getColor() -> UIColor {
            switch self {
            case .Black:    return UIColor.blackColor()
            case .Blue:     return UIColor.blueColor()
            default:        return UIColor.redColor()
            }
        }
    }
    

    /// Responds to changes in the background color segmented control.
    @IBAction func colorValueChanged(sender: UISegmentedControl) {
        
        let colorIndex: BackgroundColorIndex = BackgroundColorIndex(sender.selectedSegmentIndex)
        self.updateParentBackgroundWithColor(colorIndex.getColor())
        
        // update own userDefaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(colorIndex.rawValue, forKey: SELECTED_SEGMENT)
        userDefaults.synchronize()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // maintain segControl's selected segment from own userDefaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let selectedIndex: Int = userDefaults.integerForKey(SELECTED_SEGMENT)
        self.backgroundColorControl.selectedSegmentIndex = selectedIndex
    }
    
    /**
        Responsible for updating the shared standard defaults with a new background color when the user makes a change.
    
        :TODO: move this out of viewController
    
        :param: color   The `UIColor` the color to which the ParentApp background color should be changed.
    */
    func updateParentBackgroundWithColor(color: UIColor) {

        let sharedDefaults: NSUserDefaults = NSUserDefaults(suiteName: APP_GROUP_SUITE)!
        sharedDefaults.setValue(NSKeyedArchiver.archivedDataWithRootObject(color), forKey: BACKGROUND_COLOR)
        sharedDefaults.synchronize()
    }
}

