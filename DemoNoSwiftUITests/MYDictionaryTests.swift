//
//  MYDictionaryTests.swift
//  DemoNoSwiftUITests
//
//  Created by miao gaoliang on 2020/10/29.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import XCTest

class MyDictionaryTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
  }
  
  func testDictionaryMerge() {
    repeat {
      let m1 = [1: "a", 2: "b"]
      let m2 = [1: "c", 3: "d"]
      // 采用 $1 以后一个为准
      let r1 = m1.merging(m2, uniquingKeysWith: { $1 })
      let mr1 = [1: "c", 2:"b", 3: "d"]
      XCTAssertTrue(r1 == mr1)
    } while false
    
    repeat {
      // 当 m2 为 [], 保持原样
      let m1 = [1: "a", 2: "b"]
      let m2 = [Int: String]()
      let r2 = m1.merging(m2) { (l, _) -> String in
        return l
      }
      let mr2 = [1: "a", 2:"b"]
      XCTAssertTrue(mr2 == r2)
    } while false

    repeat {
      let m1 = [1: "a", 2: "b"]
      let m2 = [1: "c", 3: "d"]
      // 采用 $1 以后一个为准
      let r2 = m1.merging(m2) { (l, _) -> String in
        return l
      }
      let mr2 = [1: "a", 2:"b", 3: "d"]
      XCTAssertTrue(mr2 == r2)
    } while false
  }
  
  func testDictionaryValuse() {
    let map = [1: "a", 2: "b"]
    let items: [String] = map.values.compactMap( { $0 })
    let result: [String] = ["a", "b"]
    print("items = \(items); result = \(result)")
    XCTAssertTrue(items.sorted() == result)
  }
  
  func testDeleteItems() {
    var items = [[String: String]]()
    repeat {
      let i = ["id" : "1"]
      items.append(i)
    } while false
    
    repeat {
      let i = ["id" : "2"]
      items.append(i)
    } while false
    
    repeat {
      let i = ["id" : "3"]
      items.append(i)
    } while false
    
    let delete = ["id" : "1"]

    items.removeAll { (dict) -> Bool in
      return dict["id"] == delete["id"]
    }
    
    let ids: [String] = items.flatMap({ $0.values.compactMap({ $0 }) })
    let sortedIds = ids.sorted()
    XCTAssertTrue(sortedIds == ["2","3"])
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
  }
  
}
