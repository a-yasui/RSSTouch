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
    @IBOutlet weak var toolbar: NSToolbar!
    
    var config: SharedConfiguration?
    

    fileprivate let views = [
        RTPreferenceUpdateViewController(nibName: "RTPreferenceUpdateViewController", bundle: nil)!
    ]
    
    // MARK: -- Shared Instance
    static var share:RTPreferenceController = {
        return RTPreferenceController()
    }()
    
    // MARK: -- Initialize
    convenience init() {
        self.init(windowNibName: "Preferences")
    }
    
    override func windowDidLoad() {
        guard let config = self.config else {
            NSLog("Why not set Configuration!?")
            return
        }
        
        if let window = self.window {
            if self.window is RTPreference {
                (window as! RTPreference).config = config
            }
        }
        
        _switchView(index: 0)
    }
    
    // MARK: -- Actions
    @IBAction func switchView(_ sender: NSToolbarItem){
        _switchView(index: sender.tag)
        
    }
    
    // MARK: -- private
    fileprivate func _switchView(index: Int){
        let newView = views[index].view
        
        // Remove current views without toolbar
        window?.contentView?.subviews.forEach { view in
            if view != toolbar {
                view.removeFromSuperview()
            }
        }
        
        // Resize view
        let frame = window!.frame
        var newFrame = window!.frameRect(forContentRect: newView.frame)
        newFrame.origin = frame.origin
        newFrame.origin.y += frame.height - newFrame.height
        
        window?.setFrame(newFrame, display: true)
        window?.contentView?.addSubview(newView)
    }
}
