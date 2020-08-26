//
//  UIColorExt.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/16.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values

extension UIColor {
  
  // 随机颜色
  class func random() -> UIColor {
    let r = Int.random(in: 0...255)
    let g = Int.random(in: 0...255)
    let b = Int.random(in: 0...255)
    return UIColor(red: r, green: g, blue: b)
  }
  
  convenience init(red: Int, green: Int, blue: Int) {
      assert(red >= 0 && red <= 255, "Invalid red component")
      assert(green >= 0 && green <= 255, "Invalid green component")
      assert(blue >= 0 && blue <= 255, "Invalid blue component")
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    assert(alpha >= 0 && alpha <= 255, "Invalid blue component")
    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: CGFloat(alpha) / 255.0
    )
  }
  
  convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    assert(alpha >= 0 && alpha <= 255, "Invalid blue component")
    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: alpha
    )
  }
  
  // #RRGGBB
  convenience init(rgb: String) {
    let info: String
    if rgb.starts(with: "#") {
      info = rgb.substring(from: 1)
    } else if rgb.uppercased().starts(with: "0X") {
      info = rgb.substring(from: 2)
    } else {
      fatalError("must start with # or 0X")
    }
    guard let number = Int(info, radix: 16) else {
      fatalError("must sure number != nil")
    }
    self.init(rgb: number)
  }
  
  convenience init(argb: String) {
    let info: String
    if argb.starts(with: "#") {
      info = argb.substring(from: 1)
    } else if argb.uppercased().starts(with: "0X") {
      info = argb.substring(from: 2)
    }  else {
      fatalError("must start with # or 0X")
    }
    guard let number = Int(info, radix: 16) else {
      fatalError("must sure number != nil")
    }
    self.init(argb: number)
  }
  
//   0xRRGGBB
  convenience init(rgb: Int) {
    let r: Int = (rgb >> 16) & 0xFF
    let g: Int = rgb >> 8 & 0xFF
    let b: Int = rgb & 0xFF
    self.init(red: r, green: g, blue: b)
  }

  //  0xAARRGGBB
  convenience init(argb: Int) {
    let a: Int = (argb >> 24) & 0xFF
    let r: Int = (argb >> 16) & 0xFF
    let g: Int = argb >> 8 & 0xFF
    let b: Int = argb & 0xFF
    self.init(red: r, green: g, blue: b, alpha: a)
  }
}
