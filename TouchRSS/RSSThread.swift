//
//  RSSThread.swift
//  TouchRSS
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Foundation

class RSSThread: NSObject, XMLParserDelegate {
    
    var items: Array<String>;
    
    override init() {
        self.items = [];
        
        super.init()
    }
    
    func parse (url: URL)
    {
        let parser: XMLParser? = XMLParser(contentsOf: url)
        
        if ((parser) != nil){
            parser?.delegate = self
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.items = [];
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
    }
}
