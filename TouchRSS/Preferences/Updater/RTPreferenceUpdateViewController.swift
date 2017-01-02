//
//  RTPreferenceUpdateViewController.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/28.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa

class RTPreferenceUpdateViewController : NSViewController
{
    @IBOutlet weak var versionTextField : NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let versionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionTextField.stringValue = "v\(versionString)"
        }
    }
}

