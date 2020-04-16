//
//  MGLSlider.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/16.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

class MGLSlider: UISlider {
    // 1. 重写 进度条的高度修改， 另外一个方法，
    // 2。layer 变化，来实现 slider.transform = CGAffineTransform.init(scaleX: 1.0, y: 6.0)
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.trackRect(forBounds: bounds)
        let target = rect.insetBy(dx: 0, dy: 1)
        return target
    }
}
