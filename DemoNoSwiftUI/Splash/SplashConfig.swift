//
//  SplashConfig.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/10/19.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

struct SplashOptions: OptionSet {
  let rawValue: Int
  
  static let jpeg = SplashOptions(rawValue: 1 << 0)
  static let png = SplashOptions(rawValue: 1 << 1)
  static let webp = SplashOptions(rawValue: 1 << 2)
  static let gif = SplashOptions(rawValue: 1 << 3)
  static let html = SplashOptions(rawValue: 1 << 4)
  static let video = SplashOptions(rawValue: 1 << 5)

  static let image: SplashOptions = [.jpeg, .png, .webp, .gif]
  static let all: SplashOptions = [.jpeg, .png, .webp, .gif, .video, .html]
  
}

struct SplashConfig {
  // Splash 显示的时间
  var duration: TimeInterval = 5
  // 支持的类型
  var supportType: SplashOptions = SplashOptions.image
  // 等待1次，
  var waitingOnce: Bool = false
  // 尝试下载配置3次
  var retry: Int = 3
}
