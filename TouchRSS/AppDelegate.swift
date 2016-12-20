//
//  AppDelegate.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem = NSStatusBar.system().statusItem(withLength: -1)
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menu = NSMenu()
        self.statusItem.image = NSImage.init(named: "icon.png")
        self.statusItem.highlightMode = true
        self.statusItem.menu = menu
        
        let menuItem = NSMenuItem()
        menuItem.title = "Quit"
        menuItem.action = Selector("quit:")
        menu.addItem(menuItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func quit(sender: NSButton) {
        NSApplication.shared().terminate(self)
    }
}

