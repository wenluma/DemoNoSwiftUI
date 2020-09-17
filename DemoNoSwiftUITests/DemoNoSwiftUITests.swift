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
  
  func testPhone() {
    let p1 = "-1   ".isPhone()
    assert(!p1)
    let p2 = "     ".isPhone()
    assert(!p2)
    let p3 = "1-   我".isPhone()
    assert(!p3)
    let p4 = "你     我".isPhone()
    assert(!p4)
    let p5 = "+86 186 1286 5404".isPhone()
    assert(p5)
    let p6 = "54322-2438584332".isPhone()
    assert(p6)
    let p7 = "18612865404".isPhone()
    assert(p7)
    let p8 = "11234".isPhone()
    assert(p8)
    let p9 = "2012-21-20".isPhone()
    assert(!p9)
    let pa = "12-21".isPhone()
    assert(!pa)
    let pb = "2019-12-23".isPhone()
    assert(!pb)
    let pc = "你     1".isPhone()
    assert(!pc)
    let pd = "1     我".isPhone()
    assert(!pd)
    let pe = "-1   天".isPhone()
    assert(!pe)
    let pf = "     分".isPhone()
    assert(!pf)
    let pg = "4.27 - 5.3号".isPhone()
    assert(!pg)
    let ph = "0515-87364833".isPhone()
    assert(ph)
    let pi = "+8618612865404".isPhone()
    assert(pi)
    let pj = "(86)18612865404".isPhone()
    assert(pj)
  }
  
  func testReused() {
    let container = ReusedContainer<UIView>()
    container.register(factory: { (ke) -> UIView in
      return UIView()
    }, for: "k")
    let v1 = container.element(for: "k")
    let v2 = container.element(for: "k")
    let v3 = container.element(for: "k")
    
    container.reset(with: v2)
    let v4 = container.element(for: "k")
    XCTAssertTrue(v2 == v4)
    
    container.reset(with: v1)
    container.reset(with: v3)
    
    let v5 = container.element(for: "k")
    XCTAssertTrue(v5 == v1)
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testArrayDistinct() {
    var list = [1,2,3,0,2,3,1,0]
    let dis = list.distinct()
    XCTAssert(dis == [1,2,3,0], "数据不对")
    
    var list2 = [0,1,2,3,0,]
    let dis2 = list2.distinct()
    XCTAssert(dis2 != [1,2,3,0], "数据不对")

  }
  
  func testHasher() {
    var hasher = Hasher()
    hasher.combine("1")
    hasher.combine("2")
    hasher.combine("3")

    let v1 = hasher.finalize()

    var ha = Hasher()
    ha.combine("1")
    ha.combine("3")
    ha.combine("2")

    let v2 = ha.finalize()
    
    XCTAssert(v1 != v2, "\(v1) != \(v2)")
  }
  
  
  func testStride() {
    // 可以设定跳步间隔
    for index in stride(from: 0, to: 3, by: 4) {
        print(index)
    }
  }
  
}
