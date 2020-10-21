//
//  SplashItem.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/10/19.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

struct SplashItem: SplashProtocol {
  
  var md5: String?
  
  var title: String?
  
  var id: String?
  
  var downloadURI: String?
  
  var startTimestamp: TimeInterval?
  var expireTimestamp: TimeInterval?
  var version: String?
  
  var modified: TimeInterval?
  
  var savePath: String?
  
  func checkVaild() -> Bool {

    guard let start = self.startTimestamp,
      let end = self.expireTimestamp else {
      return false
    }
    
    // 当前时间 与开始时间，结束时间比对
    let date = Date()
    let nowStamp =  date.timeIntervalSince1970
    let range: ClosedRange<TimeInterval> = start ... end
    return range.contains(nowStamp)
  }
  
  func save() {
    // 记录记录数据库
    // 保存文件路径
  }
  
  func delete() {
    // 删除文件
//    删除记录
  }
}

public protocol KimSplashItemProtocol {
  // 活动 id
  var id: Int64? {get set}
  // 活动资源 url
  var url: String? {get set}
  // 资源 md5
  var md5: String? {get set}
  // 生效时间戳 liveAt
  var startTimestamp: Int64? {get set}
  // 到期时间戳 deadAt
  var expireTimestamp: Int64? {get set}
  // 跳转链接 redirectUrl
  var redirectUrl: String? {get set}
  // 更新时间戳 updateAt
  var updateTimestamp: Int64? {get set}
  // 类型 1 图片， 2 动图， 3 视频
  var type: KimSplashType? {get set}
  // 显示时间 showTime
  var duration: Int? {get set}
  // 下载后的本地资源存放路径
  var localResourceURL: URL? { get }
}

/*
 splash item 描述每一条 活动信息， 对应服务器返回的信息, 数据库入表，也是它
 */
public struct KimSplashItem: KimSplashItemProtocol {
  
  private static let flag = "kim-splash"

  // document/kim-splash/id/md5
  static func getSplashResource(with id: Int64, name: String) -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    var documentsDirectory = paths[0]
    documentsDirectory.appendPathComponent(flag)
    documentsDirectory.appendPathComponent("\(id)")
    documentsDirectory.appendPathComponent(name)
    return documentsDirectory
  }
  
  public var id: Int64?
  
  public var url: String?
  
  public var md5: String?
  
  public var startTimestamp: Int64?
  
  public var expireTimestamp: Int64?
  
  public var redirectUrl: String?
  
  public var updateTimestamp: Int64?
  
  public var type: KimSplashType?
  
  public var duration: Int?
  
  public var localResourceURL: URL? {
    guard let id = id, let md5 = md5 else {
      return nil
    }
    return KimSplashItem.getSplashResource(with: id, name: md5)
  }
  
  // 需要外部控制执行的线程， 子线程处理
  public func saveResource(data: Data?) {
    guard let data = data, let localResourceURL = localResourceURL else {
      return
    }
    do {
      try data.write(to: localResourceURL)
    } catch {
      print("data write to url = \(localResourceURL.description) failed: error = \(error)")
    }
  }
  
  // 需要外部控制执行的线程， 子线程处理
  public func deleteResource() {
    guard let localResourceURL = localResourceURL else {
      return
    }
    do {
      try FileManager.default.removeItem(at: localResourceURL)
    } catch {
      print("remove url = \(localResourceURL.description) failde: error = \(error)")
    }
  }
  
  // 满足条件 在时间范围内， true， 时间范围 外 false
  private func checkTimestamp() -> Bool {
    guard let start = startTimestamp,
      let expire = expireTimestamp,
      let id = id else {
        return false
    }
    
    let date = Date()
    let offset = TimeZone.current.secondsFromGMT()
    let current = date.timeIntervalSince1970 + Double(offset)
    let stamp = Int64(current * 1000)
    if stamp < start || stamp > expire {
      print("id = \(id); current = \(stamp); start = \(start), expire = \(expire); isVaild: false timestamp failed ")
      return false
    }
    return true
  }
  
  public func isVaild() -> Bool {
    guard let md5 = md5,
      let id = id,
      let localURL = localResourceURL else {
        print("isVaild = false; 配置信息错误")
      return false
    }
    
    if !checkTimestamp() {
      return false
    }
    
    do {
      var data = try Data(contentsOf: localURL)
      let fileMD5: String = data.MD5()
      if fileMD5 == md5 {
        return true
      } else {
        print("id = \(id); isVaild = false,reson: md5 not equal")
        return false
      }
    } catch {
      print("id = \(id); isVaild = false: file read error = \(error)")
      return false
    }
  }
}
