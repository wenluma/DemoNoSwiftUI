//
//  SplashProtocol.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/10/19.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

protocol SplashProtocol {
  // 名称
  var title: String? { get set }
  // id
  var id: String? { get set }
  // 资源url 下载链接
  var downloadURI: String? {get set}
  // 开始时间
  var startTimestamp: TimeInterval? { get set }
  // 到期时间
  var expireTimestamp: TimeInterval? {get set} // 时间戳, 到期时间
  
  var version: String? {get set}
  // 修改时间戳
  var modified: TimeInterval? {get set}
  
  var md5: String? { get set }
  
  // save path: doc/kim-splash/id/资源文件
  var savePath: String? {get set}
  
  // 格式类型 image/jpg, webp, png, gif, html, video
//  var type:
  
  // 验证有效： 时间比对，本地资源完整比对
  func checkVaild() -> Bool
  
  func save()
  
  func delete()
  
//  name: String //业务名
//  id: String // 业务id
//  startDate: String // 开始时间
//  expireDate: String // 时间戳, 到期时间
//  isVaild: Bool // 是否有效
//  path: URI // 资源路径
//  type: image/jpg, webp, png, gif, html, video
//  func checkVaild() -> Bool // 验证有效： 时间比对，本地资源完整比对
//  func deleteResource() // 删除资源信息
//  // 本地的保存格式
//  doc/kim-splash/id/资源文件
//  // 删除方式
//  删除对应 id 的文件夹
//  version: 业务版本
//  modified: 修改时间戳， 或者场景时间戳

}


// 定义支持的类型: image, 动图， 视频
public enum KimSplashType: Int {
  // 图片类型 png or jpg
  case image = 1
  // 动图
  case gif = 2
  // 视频
  case video = 3
}

// splash 的配置信息
public struct KimSplashConfig {
  // 当前版本支持的类型， 客户端兼容判断
  private static let supoortTypes: [KimSplashType] = [.image]
  
  // 默认展示时常
  var duration: TimeInterval = 5
  
  // 判断支持的类型
  public static func isSupportType(type: Int) -> Bool {
    guard let splashType = KimSplashType(rawValue: type) else {
      return false
    }
    return supoortTypes.contains(splashType)
  }
  
  // 判断支持的类型
  public static func isSupportType(type: String) -> Bool {
    guard let intType = Int(type) else {
      return false
    }
    return isSupportType(type: intType)
  }
  
}
