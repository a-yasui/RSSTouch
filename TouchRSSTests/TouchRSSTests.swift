//
//  TouchRSSTests.swift
//  TouchRSSTests
//
//  Created by At Yasui on 2016/12/20.
//  Copyright © 2016年 At Yasui. All rights reserved.
//

import Fuzi
import XCTest
@testable import TouchRSS

class TouchRSSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_xml_parse() {
        let path = Bundle.path(forResource: "rss", ofType: "xml", inDirectory: "")
        
        if path == nil {
            print("WTF!!??")
            return;
        }
        
        let xml:String = try! String.init(contentsOfFile: path!)
        
        let thread = RSSThread()
        
        thread.xml_parse(html: xml)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
