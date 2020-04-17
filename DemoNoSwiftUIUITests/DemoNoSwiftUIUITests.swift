//
//  DemoNoSwiftUIUITests.swift
//  DemoNoSwiftUIUITests
//
//  Created by miao gaoliang on 2020/4/10.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import XCTest
import DemoNoSwiftUI

class DemoNoSwiftUIUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let originRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        let supV = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let viewa = UIView(frame: originRect)
        supV.addSubview(viewa)
        viewa.mgl_x = 10
        
        assert(viewa.mgl_frame.equalTo(CGRect(x: 10, y: 0, width: 50, height: 50)))
        assert(viewa.mgl_x == 10)
        
        viewa.mgl_x = 0
        assert(viewa.mgl_frame.equalTo(CGRect(x: 0, y: 0, width: 50, height: 50)))

        viewa.mgl_y = 10

        assert(viewa.mgl_frame.equalTo(CGRect(x: 0, y: 10, width: 50, height: 50)))
        assert(viewa.mgl_y == 10)
        
        viewa.mgl_y = 0
        assert(viewa.mgl_frame.equalTo(CGRect(x: 0, y: 0, width: 50, height: 50)))

        
        viewa.mgl_width = 60
        assert(viewa.mgl_frame.equalTo(CGRect(x: 0, y: 0, width: 60, height: 50)))
        assert(viewa.mgl_width == 60)

        viewa.mgl_heigh = 70
        assert(viewa.mgl_frame.equalTo(CGRect(x: 0, y: 0, width: 60, height: 70)))
        assert(viewa.mgl_heigh == 70)

        viewa.mgl_x = 10
        assert(viewa.mgl_frame.equalTo(CGRect(x: 10, y: 0, width: 60, height: 70)))
        assert(viewa.mgl_heigh == 70)
        assert(viewa.mgl_x == 10)
        assert(viewa.mgl_width == 60)

        viewa.mgl_y = 10
        assert(viewa.mgl_frame.equalTo(CGRect(x: 10, y: 10, width: 60, height: 70)))
        assert(viewa.mgl_heigh == 70)
        assert(viewa.mgl_x == 10)
        assert(viewa.mgl_y == 10)
        assert(viewa.mgl_width == 60)
        
        viewa.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        assert(viewa.mgl_center == CGPoint(x: 25, y: 25))
        assert(viewa.mgl_center == viewa.center)
        
        assert(viewa.mgl_centerX == 25)
        assert(viewa.mgl_centerY == 25)

        viewa.mgl_offset(x: 10)
        assert(viewa.mgl_centerX == 25 + 10)

        viewa.mgl_offset(y: 10)
        assert(viewa.mgl_centerY == 25 + 10)
        assert(viewa.mgl_center == CGPoint(x: 25 + 10, y: 25 + 10))

        viewa.center = CGPoint(x: 25, y: 25)
        assert(viewa.frame == CGRect(x: 0, y: 0, width: 50, height: 50))
        
        viewa.mgl_offset(point: CGPoint(x: 10, y: 10))
        assert(viewa.mgl_center == CGPoint(x: 25 + 10, y: 25 + 10))

        assert(viewa.mgl_left == 10)
        assert(viewa.mgl_top == 10)
        
        viewa.mgl_right = 10
        assert(viewa.frame == CGRect(x: 100 - 50 - 10, y: 10, width: 50, height: 50))
        
        viewa.mgl_size = CGSize(width: 60, height: 60)
        assert(viewa.frame == CGRect(x: 100 - 50 - 10, y: 10, width: 60, height: 60))

        viewa.mgl_frame = originRect
        assert(viewa.frame == originRect)

        viewa.mgl_bottom = 10
        assert(viewa.frame != CGRect(x: 0, y: 100 - 50 - 10, width: 60, height: 60))
        assert(viewa.frame == CGRect(x: 0, y: 100 - 50 - 10, width: 50, height: 50))

        viewa.mgl_top = 10
        assert(viewa.frame == CGRect(x: 0, y: 10, width: 50, height: 50))

        viewa.mgl_top = 0
        assert(viewa.frame == CGRect(x: 0, y: 0, width: 50, height: 50))

        viewa.mgl_edgeInsets(forFrame: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        assert(viewa.frame == CGRect(x: 10, y: 10, width: 30, height: 30))

        viewa.mgl_frame = originRect
        viewa.mgl_edgeInset(forFrameLR: 10)
        assert(viewa.frame == CGRect(x: 10, y: 0, width: 30, height: 50))
        
        viewa.mgl_edgeInset(forFrameTB: 10)
        assert(viewa.frame == CGRect(x: 10, y: 10, width: 30, height: 30))

        
        viewa.mgl_edgeInSuperView(withLR: 10)
        assert(viewa.frame == CGRect(x: 10, y: 0, width: 80, height: 100))

        viewa.mgl_edgeInSuperView(withTB: 10)
        assert(viewa.frame == CGRect(x: 0, y: 10, width: 100, height: 80))
        
        
        viewa.mgl_edgeInSuperView(withLR: 10, withTB: 10)
        assert(viewa.frame == CGRect(x: 10, y: 10, width: 80, height: 80))

        viewa.mgl_edgeInSuperView(withPadding: UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 30))
        assert(viewa.frame == CGRect(x: 20, y: 10, width: 100-30-20, height:100-20-10))

        viewa.mgl_centerInSuperView()
        assert(viewa.center == CGPoint(x: 50, y: 50))

        
        
//        print("mgl: \(viewa.frame)")
//        print("mgl: \(viewa.mgl_x)")
        
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
