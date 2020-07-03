//
//  MGLDataCollection.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/2.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
/*
 代表着一个数据集合
 数组元素是整体，字典快速获取到格式
 包含数组，字典，通过特定的 key 来快速找到索引对象, 一个整体的方式
 */
class KimDataCollection<Key: Hashable, Target> {
  var items: [Target] = []
  var keyTargetDict: [Key: Target] = [:]

  subscript(index: Int) -> Target? {
    get {
      return items[index]
    } set {
      if newValue != nil {
        items[index] = newValue!
      } else {
        if (0..<items.count).contains(index) {
          items.remove(at: index)
        }
      }
    }
  }
  
  subscript(targetBy: Key) -> Target? {
    get {
      return keyTargetDict[targetBy]
    } set {
      keyTargetDict[targetBy] = newValue
    }
  }
  
  func hasTarget(by key: Key) -> Bool {
    return keyTargetDict[key] != nil
  }
}

class KimDataCollection2<Key: Hashable, Target, Value>: KimDataCollection<Key, Target> {
  var keyValueDict:[Key : Value] = [:]
 
  // keyValueDict[valueBy: key]  = xxx
  subscript(valueBy key: Key) -> Value? {
    get {
      return keyValueDict[key]
    } set {
      keyValueDict[key] = newValue
    }
  }
  
  func hasValue(by key: Key) -> Bool {
    return keyValueDict[key] != nil
  }
}
