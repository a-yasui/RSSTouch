//
//  ViewController.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
class ViewController: NSViewController, RSSThreadDelegate {
    var thread: RSSThread = RSSThread()
    var item: Array<Item> = []
    let lane = NSView()
    
    var config: SharedConfiguration?

    override func loadView() {
        self.view = NSView()
    }

    override func viewDidAppear() {
        lane.frame = CGRect(x: 0, y: 0, width: self.view.frame.width*2, height: self.view.frame.height)
        lane.layer?.position = CGPoint(x: 0, y: 0)
        self.view.addSubview(lane)
        
        self.thread.delegate = self
        self.load_of_rss(url: URL(string: "http://headlines.yahoo.co.jp/rss/all-dom.xml")!)
    }
    
    func load_of_rss (url: URL){
        self.thread.parse(url)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    /**
     * くるくる回す部分
     */
    func start() {
        NSLog("lane width:\(self.lane.frame.width) view width:\(self.view.frame.width)")

        let animation = CABasicAnimation(keyPath: "position")
        animation.repeatCount = .infinity
        animation.duration = CFTimeInterval(self.view.frame.width / 100)
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
extension ViewController
{
    @IBAction func clickEvent(_ sender:AnyObject)
    {
        NSLog("Sender: \(sender)")
    }
    
}

@available(OSX 10.12.2, *)
extension ViewController {
    func makeButton (x: Int, text:String, url:URL) ->NSView {
        guard let config:SharedConfiguration = self.config else {
            NSLog("Why not set Config in ViewController !?")
            return NSView()
        }
        
        let color:NSColor = config.textColor()
        let attributeText = NSMutableAttributedString(string: text)

        let field = TRTextField(frame: NSRect(x: x, y: 0, width: 30, height: 30))
        
        let attr = [
//            NSLinkAttributeName: url,
            :
        ] as [String : Any]
        
        attributeText.beginEditing()
        let range = NSRange(location: 0, length: attributeText.length)
        attributeText.addAttributes(attr, range: range)
        attributeText.endEditing()
        
        let test = NSMutableAttributedString(string:"")
        
        test.beginEditing()
        test.append(attributeText)
        test.append(NSAttributedString(string: ""))
        let attr1 = [
            NSForegroundColorAttributeName: color,
            NSStrikethroughColorAttributeName: color,
            NSStrokeColorAttributeName: color,
            NSUnderlineStyleAttributeName: NSUnderlineStyle.styleNone.rawValue,
            NSFontAttributeName: config.font(),
            ] as [String : Any]
        test.addAttributes(attr1, range: NSRange(location:0, length: test.length))
        test.endEditing()
        
//        field.linkTextAttributes = attr
        
        field.attributedStringValue = test
        field.drawsBackground = false
        field.isBordered = false
        field.isEditable = false
        field.isSelectable = false
        field.textColor = color
        field.sizeToFit()
        
        field.wantsLayer = true
        field.allowedTouchTypes = .direct

        return field
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
            
            let vf = self.view.frame
            self.view.frame = NSRect( x:vf.minX, y:vf.minY, width: CGFloat(point), height:vf.height)
            
            let lf = self.lane.frame
            self.lane.frame = NSRect( x:lf.minX, y:lf.minY, width: CGFloat(point), height:lf.height)

            self.start()
        }
    }
}

