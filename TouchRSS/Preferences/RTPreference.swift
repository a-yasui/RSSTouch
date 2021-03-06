//
//  RTPreference.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/28.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa

class RTPreference : NSPanel {
    
    var config: SharedConfiguration?
    
    override func cancelOperation(_ sender: Any?) {
        self.close()
    }
    
    func setConfiguration(config: SharedConfiguration){
        self.config = config
    }
}
