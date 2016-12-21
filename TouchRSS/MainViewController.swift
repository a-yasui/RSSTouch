//
//  MainViewController.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/21.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Cocoa


class MainViewController: NSViewController
{
    
    override func viewDidAppear() {
        
        NSLog("View Did Appears")
//        let attributeText = NSMutableAttributedString(string: "テスト")
//        
//        let field = TRTextField(frame: NSRect(x: 0, y: 0, width: 30, height: 30))
//        let attr = [
////            NSLinkAttributeName: "https://google.com/",
//        :] as [String : Any]
//        
//        attributeText.beginEditing()
//        let range = NSRange(location: 0, length: attributeText.length)
//        attributeText.addAttributes(attr, range: range)
//        attributeText.endEditing()
//        
//        let test = NSMutableAttributedString(string:"|")
//        
//        test.beginEditing()
//        test.append(attributeText)
//        test.append(NSAttributedString(string: "|"))
//        let attr1 = [
//            NSForegroundColorAttributeName: NSColor.orange,
//            NSStrikethroughColorAttributeName: NSColor.orange,
//            NSStrokeColorAttributeName: NSColor.orange,
//            NSUnderlineStyleAttributeName: NSUnderlineStyle.styleNone.rawValue,
//            NSFontAttributeName: NSFont(name: "HelveticaNeue-Bold", size: 21.0)!,
//        ] as [String : Any]
//        test.addAttributes(attr1, range: NSRange(location:0, length: test.length))
//        test.endEditing()
//        
//        field.attributedStringValue = test
//        field.drawsBackground = false
//        field.isBordered = false
//        field.isEditable = false
//        field.isSelectable = true
//        field.action = #selector(MainViewController.click(_:))
//        field.sizeToFit()
//        
//        self.view.addSubview(field)
        
    }
    
    func click(_ test: AnyObject)
    {
        NSLog("hogehoge \(test)")
    }
    
}

extension MainViewController: NSTextFieldDelegate
{
    func textField(_ textField: NSTextField, textView: NSTextView, shouldSelectCandidateAt index: Int) -> Bool {
        return true
    }
}
