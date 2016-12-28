//
//  SharedConfiguration.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/28.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa


class SharedConfiguration : NSObject
{
    let COLOR = "info.a-yasui.cocoa.touchrss.color"
    let FONT = "info.a-yasui.cocoa.touchrss.font"
    var defaults: UserDefaults
    
    override init()
    {
        self.defaults = UserDefaults.standard

        super.init()
        
        self.textColor()
        
        self.font()
    }
    
    /**
     */
    func setTextColor(color: NSColor){
        let data = NSKeyedArchiver.archivedData(withRootObject: color)
        self.defaults.set(data, forKey: self.COLOR)
        self.defaults.synchronize()
    }
    
    /**
     */
    func textColor() -> NSColor{
        var color = self.defaults.object(forKey: self.COLOR)
        
        if color is NSData {
            let cc = NSKeyedUnarchiver.unarchiveObject(with: color as! Data)
            if cc is NSColor {
                return cc as! NSColor
            }
        }
        
        color = NSColor.orange
        self.setTextColor(color: color as! NSColor)
        return color as! NSColor;
    }
    
    /**
     */
    func setFont(font: NSFont) {
        let ff = NSKeyedArchiver.archivedData(withRootObject: font)
        self.defaults.set(ff, forKey: self.FONT)
        self.defaults.synchronize()
    }
    
    /**
     */
    func font() -> NSFont{
        var font = self.defaults.object(forKey: self.FONT)
        
        if font is NSData {
            let ff = NSKeyedUnarchiver.unarchiveObject(with: font as! Data)
            if ff is NSFont {
                return ff as! NSFont
            }
        }
        
        font = NSFont(name: "HelveticaNeue-Bold", size: 21.0)
        self.setFont(font: font as! NSFont)
        return font as! NSFont;
    }
}
