//
//  Item.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Foundation

/**
 * TouchBar に表示させる内容
 */
class Item : NSObject
{
    var title:String = "";
    var url:URL;
    
    init(title: String, url: URL) {
        self.title = title;
        self.url = url;
        
        super.init()
    }
    
    func getTitle() -> String{
        return self.title;
    }
    
    func getURL() -> URL{
        return self.url;
    }
}
