//
//  TRTextField.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/21.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa
class TRTextField : NSTextField
{
//    
//    override func mouseDown(with event: NSEvent) {
//        if (self.action != nil){
//            NSLog("How do i call selector?")
//            self.perform(self.action)
//        }
//    }
    @available(macOS 10.10.3, *)
    override func pressureChange(with event: NSEvent) {
        
        if event.stage == 2, !self.isEditable {
            NSLog("pressureChange")
            self.isEditable = true
            self.selectText(self)
        }
    }
}
