//
//  RTOreferenceController.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/28.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa

class RTPreferenceController : NSWindowController
{
    static var share:RTPreferenceController = {
        return RTPreferenceController()
    }()
    
    convenience init() {
        self.init(windowNibName: "Preferences")
    }
}
