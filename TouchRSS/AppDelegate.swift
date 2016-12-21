//
//  AppDelegate.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, NSTouchBarProvider {

    var statusItem = NSStatusBar.system().statusItem(withLength: -1)
    var touchBar: NSTouchBar?

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.touchBar = makePrimaryTouchBar()
        
        // メニュー
        let menu = NSMenu()
        self.statusItem.image = NSImage.init(named: "icon.png")
        self.statusItem.highlightMode = true
        self.statusItem.menu = menu
        
        class QuitMenu: NSMenuItem{}
        
        let menuItem = QuitMenu()
        menuItem.title = "Quit"
        menuItem.action = #selector(quit(sender:))
        menuItem.setAccessibilityEnabled(true)
        menu.addItem(menuItem)
        
        // 初期状態ではメニューが選べないようになるため
        menu.autoenablesItems = false;
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func quit(sender: NSButton) {
        NSApplication.shared().terminate(self)
    }
}

fileprivate extension NSTouchBarItemIdentifier {
    static let rss = NSTouchBarItemIdentifier("jp.designegg.mac.touchbar.start")
}

@available(OSX 10.12.2, *)
extension AppDelegate: NSTouchBarDelegate {
    
    func makePrimaryTouchBar() -> NSTouchBar {
        let mainBar = NSTouchBar()
        mainBar.delegate = self
        mainBar.defaultItemIdentifiers = [.flexibleSpace , .rss]
        return mainBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        if (identifier == .rss){
            let item = NSCustomTouchBarItem(identifier: identifier)
            item.viewController = ViewController()
            return item
        }
        NSLog("Identifier: \(identifier)")
        return nil
    }

}
