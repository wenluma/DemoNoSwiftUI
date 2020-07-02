//
//  CGRectExtension.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/30.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import CoreGraphics

// https://stackoverflow.com/questions/26918886/how-can-i-increase-the-size-of-a-cgrect-by-a-certain-percent-value
//
extension CGRect {
  mutating func scaleXY(by scaleXY: CGFloat) -> CGRect {
    return self.applying(CGAffineTransform.identity.scaledBy(x: scaleXY, y: scaleXY))
  }
}
