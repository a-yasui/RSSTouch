//
//  RSSThread.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Foundation
import Fuzi

class RSSThread: NSObject, XMLParserDelegate {
    
    var items: Array<String>;
    
    override init() {
        self.items = [];
        
        super.init()
    }
    
    func parse (url: URL)
    {
        let request = NSMutableURLRequest(url: url)
        
        // set the method(HTTP-GET)
        request.httpMethod = "GET"
        
        // use NSURLSessionDataTask
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if (error == nil) {
                let result: String = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                print(result)
                
                self.xml_parse(html: result)
            } else {
                print(error)
            }
        })
        task.resume()
    }
    
    func xml_parse( html: String){
        if let doc = try? XMLDocument(string: html) {
            if let root = doc.root {
                print(root.tag)
                
                // define a prefix for a namespace
                doc.definePrefix("rss", defaultNamespace: "http://backend.userland.com/blogChannelModule")
                
                // get first child element with given tag in namespace(optional)
                print(root.firstChild(tag: "title", inNamespace: "rss"))
                
                // iterate through all children
                for element in root.children {
                    print("\(index) \(element.tag): \(element.attributes)")
                }
            }

        }
    }
    
}
