//
//  SwiftMMDTests.swift
//  SwiftMMDTests
//
//  Created by Steve Brokaw on 11/18/15.
//  Copyright © 2015 Steven Brokaw. All rights reserved.
//

import XCTest
@testable import SwiftMMD

class SwiftMMDTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testRender() {
        let s = "Title: Test Document\n" +
        "#This is headline 1\n" +
        "##This is headline 2\n"
        let output = s.mmdToHTML()
        print("\(output)")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
