//
//  ViewController.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa

extension NSMutableAttributedString {
    public convenience init(string: String, url:URL){
        self.init(string: string)
        let range = NSRange(location: 0, length: self.length)
        
        self.beginEditing()
        self.addAttribute(NSLinkAttributeName, value: url.absoluteString, range: range)
        self.addAttribute(NSForegroundColorAttributeName, value: NSColor.white, range: range)
        self.addAttribute(NSStrokeColorAttributeName, value: NSColor.white, range: range)
        
        self.endEditing()
    }
}

@available(OSX 10.12.2, *)
class ViewController: NSViewController, RSSThreadDelegate {
    var thread: RSSThread = RSSThread()
    var item: Array<Item> = []
    let lane = NSView()

    override func loadView() {
        self.view = NSView()
    }

    override func viewDidAppear() {
        NSLog("test!!")
    
        lane.frame = CGRect(x: 0, y: 0, width: self.view.frame.width*2, height: self.view.frame.height)
        lane.layer?.position = CGPoint(x: 0, y: 0)
        self.view.addSubview(lane)
        
        self.thread.delegate = self
        self.thread.parse(URL(string: "http://news.yahoo.co.jp/pickup/computer/rss.xml")!)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    func start() {
        NSLog("lane width:\(self.lane.frame.width) view width:\(self.view.frame.width)")

        let animation = CABasicAnimation(keyPath: "position")
        animation.repeatCount = .infinity
        animation.duration = 16
        animation.fromValue = lane.layer?.position
        animation.toValue = NSValue(point: NSPoint(x: -self.view.frame.width, y: 0))
        lane.layer?.add(animation, forKey: "position")
    }
    
    func click(obj: NSButton){
        NSLog("object: \(obj)")
        let url: URL = URL(string: obj.identifier!)!
        NSWorkspace.shared().open(url)
    }
}


@available(OSX 10.12.2, *)
extension ViewController {
    func makeButton (x: Int, text:String, url:URL) ->NSView {
        let button : NSButton = NSButton(frame: NSRect(x: x, y: 0, width: 30, height: 30))
        
        let text = NSMutableAttributedString(string: text, url: url)
        
        button.attributedTitle = text
//        button.identifier = url.absoluteString
//        button.action = Selector("click:")
        button.sizeToFit()
        return button

    }
    
    func notify(rssThread: RSSThread) {
        self.item = rssThread.items;
        DispatchQueue.main.async {
            var point: Int = 0
            for i in 0..<self.item.count {
                let btn = self.makeButton(x: point, text: self.item[i].getTitle(), url: self.item[i].getURL())
                NSLog("get \(i) => \(self.item[i].getTitle()) at xpoint \(point) width fit: \(btn.frame.size.width)")

                point = point + Int(btn.frame.size.width)

                self.lane.addSubview(btn)
            }
            
            let f = self.lane.frame
            self.view.frame = NSRect( x:f.minX, y:f.minY, width: CGFloat(point), height:f.height)
            self.start()
        }
    }
}

