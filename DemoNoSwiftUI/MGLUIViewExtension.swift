//
//  MGLUIViewExtension.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/17.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

//MARK: 坐标变换
extension UIView {
//    MARK: x, y, width, heigh
    var mgl_x: CGFloat {
        get {
            frame.origin.x
        }
        set {
            let rect = frame
            frame = CGRect(x: newValue, y: rect.origin.y, width: rect.width, height: rect.height)
        }
    }
    // 指定 右边界
    var kim_maxX: CGFloat {
        get {
            frame.maxX
        }
        set {
            let rect = frame
            frame = rect.offsetBy(dx: newValue - frame.maxX, dy: 0)
        }
    }
    
    var mgl_y: CGFloat {
        get {
            frame.origin.y
        }
        set {
            let rect = frame
            frame = CGRect(x: rect.origin.x , y: newValue, width: rect.width, height: rect.height)
        }
    }
    
    // 指定 低边界
    var kim_maxY: CGFloat {
        get {
            frame.maxY
        }
        set {
            let rect = frame
            frame = rect.offsetBy(dx: 0, dy: newValue - frame.maxY)
        }
    }
    
    var mgl_width: CGFloat {
        get {
            return frame.width
        }
        set {
            let rect = frame
            frame = CGRect(x: rect.origin.x, y: rect.origin.y, width: newValue, height: rect.height)
        }
    }
    
    var mgl_heigh: CGFloat {
        get {
            return frame.height
        }
        set {
            let rect = frame
            frame = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.width, height: newValue)
        }
    }
    
    var mgl_center: CGPoint {
        get {
            center
        }
        set {
            center = newValue
        }
    }
    
    var mgl_centerX: CGFloat {
        get {
            center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    var mgl_centerY: CGFloat {
        get {
            center.y
        }
        set {
            center = CGPoint(x:center.x , y: newValue)
        }
    }
    
    var mgl_size: CGSize {
        get {
            frame.size
        }
        set {
            frame =  CGRect(x: mgl_x, y: mgl_y, width: newValue.width, height: newValue.height)
        }
    }
    
    var mgl_frame: CGRect {
        get {
            frame
        }
        set {
            frame = newValue
        }
    }
    
//    MARK: top, left, bottom, right
    var mgl_top: CGFloat {
        get {
            mgl_y
        }
        set {
            mgl_y = newValue
        }
    }
    
    var mgl_left: CGFloat {
        get {
            mgl_x
        }
        set {
            mgl_x = newValue
        }
    }
    
    var mgl_bottom: CGFloat {
        get {
            guard let superview = superview else {
                fatalError("must add to super view")
            }
            return superview.bounds.height - frame.height - mgl_y

        }
        set {
            guard let superview = superview else {
                fatalError("must add to super view")
            }
            
            mgl_y = superview.bounds.height - frame.height - newValue
        }
    }
    
    var mgl_right: CGFloat {
        get {
            guard let superview = superview else {
                fatalError("must add to super view")
            }
            return superview.bounds.width - frame.width - mgl_x
        }
        set {
            guard let superview = superview else {
                fatalError("must add to super view")
            }
            mgl_x = superview.bounds.width - frame.width - newValue
        }
    }
//    MARK: offsetx, offsetY, offsetPoint
    func mgl_offset(x dx: CGFloat) -> Void {
        let rect = frame
        frame = rect.offsetBy(dx: dx, dy: 0)
    }
    
    func mgl_offset(y dy: CGFloat) -> Void {
        let rect = frame
        frame = rect.offsetBy(dx: 0, dy: dy)
    }
    
    func mgl_offset(dx: CGFloat ,dy: CGFloat) -> Void {
        let rect = frame
        frame = rect.offsetBy(dx: dx, dy: dy)
    }
    
    func mgl_offset(point offsetPoint: CGPoint) -> Void {
        let rect = frame
        frame = rect.offsetBy(dx: offsetPoint.x, dy: offsetPoint.y)
    }
    
//    MARK: edge frame
    func mgl_edgeInsets(forFrame edgeInsets: UIEdgeInsets) -> Void {
        let rect = frame
        frame = rect.inset(by: edgeInsets)
    }
    
    func mgl_edgeInset(forFrameLR dx: CGFloat) -> Void {
        let rect = frame
        frame = rect.insetBy(dx: dx, dy: 0)
    }
    
    func mgl_edgeInset(forFrameTB dy: CGFloat) -> Void {
        let rect = frame
        frame = rect.insetBy(dx: 0, dy: dy)
    }
    
//    MARK: equal super, center in super
    func mgl_eqToSuperView() -> Void {
        guard let superview = superview else {
            fatalError("must add to super view")
        }
        frame = superview.bounds
    }
    
    func mgl_centerInSuperView() -> Void {
        guard let superview = superview else {
            fatalError("must add to super view")
        }
        center = CGPoint(x: superview.bounds.midX, y: superview.bounds.midY)
    }
    
    /// 扩展view
    /// - Parameter edgeDx: newWidth = oldWidth -  edgeDx * 2
    /// - Returns:edgeDx > 0, 变小， edgeDx < 0, 变大
    func mgl_edgeInSuperView(withLR dx: CGFloat) -> Void {
        mgl_edgeInSuperView(withLR: dx, withTB: 0)
    }
    
    func mgl_edgeInSuperView(withTB dy: CGFloat) -> Void {
        mgl_edgeInSuperView(withLR: 0, withTB: dy)
    }
    
    func mgl_edgeInSuperView(withLR dx: CGFloat, withTB dy: CGFloat) -> Void {
        guard let superview = superview else {
            fatalError("must add to super view")
        }
        let rect = superview.bounds
        frame = rect.insetBy(dx: dx, dy: dy)
    }
    
    func mgl_edgeInSuperView(withPadding edgeInsets: UIEdgeInsets) -> Void {
        guard let superview = superview else {
            fatalError("must add to super view")
        }
        let rect = superview.bounds
        frame = rect.inset(by: edgeInsets)
    }
}

extension UIScrollView {
    public func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height + self.contentInset.bottom + self.safeAreaInsets.bottom)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}

extension UIView {
//    https://stackoverflow.com/questions/15850417/cocoa-autolayout-content-hugging-vs-content-compression-resistance-priority
    
    // 抵抗使其变大， 内缩， less， <
    func mgl_setVerticalContentHugging(with priority :UILayoutPriority) -> Void {
        setContentHuggingPriority(priority, for: .vertical)
    }
    
    func mgl_verticalContentHugging() -> UILayoutPriority {
        return contentHuggingPriority(for: .vertical)
    }
    
    func mgl_setHorizontalContentHugging(with priority :UILayoutPriority) -> Void {
        setContentHuggingPriority(priority, for: .horizontal)
    }
    
    func mgl_horizontalContentHugging() -> UILayoutPriority {
        return contentHuggingPriority(for: .horizontal)
    }
    
    // 抵抗使其变小， 外推， large, >
    func mgl_setHorizontalContentCompressionResistance(with priority :UILayoutPriority) -> Void {
        setContentCompressionResistancePriority(priority, for: .horizontal)
    }
    
    func mgl_horizontalContentCompressionResistance(with priority :UILayoutPriority) -> UILayoutPriority {
        return contentCompressionResistancePriority(for: .horizontal)
    }
    
    func mgl_setVerticalContentCompressionResistance(with priority :UILayoutPriority) -> Void {
        setContentCompressionResistancePriority(priority, for: .vertical)
    }
    
    func mgl_verticalContentCompressionResistance(with priority :UILayoutPriority) -> UILayoutPriority {
        return contentCompressionResistancePriority(for: .vertical)
    }
}

// MARK: - get image
extension UIView {
//https://stackoverflow.com/questions/30696307/how-to-convert-a-uiview-to-an-image
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
//MARK: 锚点 仿射变换
extension UIView {
  func applyTransform(withScale scale: CGFloat, anchorPoint: CGPoint) {
    layer.anchorPoint = anchorPoint
    let scale = scale != 0 ? scale : CGFloat.leastNonzeroMagnitude
    let xPadding = 1/scale * (anchorPoint.x - 0.5) * bounds.width
    let yPadding = 1/scale * (anchorPoint.y - 0.5) * bounds.height
    
    transform = CGAffineTransform(scaleX: scale, y: scale)
      .translatedBy(x: xPadding, y: yPadding)
      .concatenating(transform)
  }
  
  func setAnchorPoint(_ point: CGPoint) {
      var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
      var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

      newPoint = newPoint.applying(transform)
      oldPoint = oldPoint.applying(transform)

      var position = layer.position

      position.x -= oldPoint.x
      position.x += newPoint.x

      position.y -= oldPoint.y
      position.y += newPoint.y

      layer.position = position
      layer.anchorPoint = point
  }
}
