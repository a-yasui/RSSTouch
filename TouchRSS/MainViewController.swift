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
    }
    
    func click(_ test: AnyObject)
    {
        NSLog("hogehoge \(test)")
    }
    
}
