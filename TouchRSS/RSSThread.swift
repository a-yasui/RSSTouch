//
//  RSSThread.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Foundation
import Fuzi


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

protocol RSSThreadDelegate {
    func notify(rssThread: RSSThread)
}

/**
 */
class RSSThread: NSObject, XMLParserDelegate {
    
    let DEFAILT_URL: String = "https://a-yasui.github.io/RSSTouch/"
    
    var items: Array<Item>;
    
    var delegate: RSSThreadDelegate?
    
    override init() {
        self.items = [];
        
        super.init()
    }
    
    
    
    func parse (_ url: URL)
    {
        DispatchQueue(label:"jp.designegg.mac.queue.rssfetch").async {
            
            let request = NSMutableURLRequest(url: url)
            
            // set the method(HTTP-GET)
            request.httpMethod = "GET"
            
            // use NSURLSessionDataTask
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                if (error == nil) {
                    let result: String = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//                    NSLog(result)
                    
                    self.xml_parse(html: result)
                } else {
                    NSLog("\(error)")
                    self.add_item(title: (error?.localizedDescription)!, link: self.DEFAILT_URL)
                    if (self.delegate != nil) {
                        self.delegate!.notify(rssThread: self)
                    }
                }
            })
            task.resume()
        }
    }
    
    func add_item(title:String, link: String){
        self.items.append(Item(title: title, url: URL(string: link)!))
    }
    
    
    func xml_parse( html: String){
        if let doc = try? XMLDocument(string: html) {
            if let root = doc.root {
                let rss = root.xpath("/rss//item/*")
                NSLog("Item: \(rss.count)")

                // iterate through all children
                var title = ""
                
                for element in rss{
                    if(element.tag == "title") {
                        title = element.stringValue
                    } else if (element.tag == "link"){
                        self.add_item(title: title, link: element.stringValue)
                    }
                    NSLog("Elements \(element.tag): \(element.attributes)")
                }
                
                NSLog("\(self.items)")
                if (self.delegate != nil) {
                    self.delegate!.notify(rssThread: self)
                }
            }

        }
    }
    
}
