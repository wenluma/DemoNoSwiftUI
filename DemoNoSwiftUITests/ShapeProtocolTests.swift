//
//  ShapeProtocolTests.swift
//  DemoNoSwiftUITests
//
//  Created by miao gaoliang on 2020/9/22.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import XCTest
@testable import DemoNoSwiftUI

class ShapeProtocolTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testShape() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    let shape = Shape()
    shape.draw()
    
    let rect = Rect()
    rect.draw()
    
    let circle = Circle()
    circle.draw()
    
  }
  
  func testPhone() {
    
  }
  
  
  
}
