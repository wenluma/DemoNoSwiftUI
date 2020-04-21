//
//  DemoNoSwiftUITests.swift
//  DemoNoSwiftUITests
//
//  Created by miao gaoliang on 2020/4/10.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import XCTest
@testable import DemoNoSwiftUI

class DemoNoSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
                let hello = "hello"
                let start = hello.index(from: 1)
                let end = hello.index(from: 3)
                let sub = hello.substring(with: Range(uncheckedBounds: (lower: 1, upper: 4))) // [1,4)
        //        let sub = hello.range(r)
                assert("ell" == String(sub))
        print(hello[1...1])
        assert("ell" == hello[1...3])// [1,3] index 的边界
        assert("el" == hello[1..<3])// [1,3) index 的边界
        assert("ello" == hello[1...])// [1,end] index 的边界
        assert("he" == hello.prefix(2))
        assert("he" != hello.prefix(3))
        assert("lo" == hello.suffix(2))
        assert("llo" != hello.suffix(2))


    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
