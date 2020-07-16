//
//  MGLImageExtension.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/15.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  func mirror(orientation: UIImage.Orientation) -> UIImage? {
    guard self.cgImage != nil else {
      return nil
    }
    return UIImage(cgImage: cgImage!, scale: self.scale, orientation: orientation)
  }
}

// MARK: - to Attribute string
// https://www.jianshu.com/p/89ed22f50a9c
// 搜索 AttributedString.key https://developer.apple.com/documentation/foundation/nsattributedstring/key
extension UIImage {
  func toAttributedString(with heightRatio: CGFloat = 0,
                          tintColor: UIColor? = nil,
                          font: UIFont? = nil) -> NSAttributedString {
    let attachment = NSTextAttachment()
    let image: UIImage
    if let tintColor = tintColor {
      image = self.withTintColor(tintColor, renderingMode: .alwaysTemplate)
    } else {
      image = self
    }
    attachment.image = self
    
    if let font = font {
      attachment.bounds = CGRect(x: 0, y: font.descender/2, width: image.size.width, height: image.size.height)
    }
    
    if heightRatio > 0 {
      let ratio: CGFloat = image.size.width / image.size.height
      let attachmentBounds = attachment.bounds
      
      attachment.bounds = CGRect(x: attachmentBounds.origin.x,
                                 y: attachmentBounds.origin.y,
                                 width: ratio * heightRatio,
                                 height: heightRatio)
    }
    return NSAttributedString(attachment: attachment)
  }
}
