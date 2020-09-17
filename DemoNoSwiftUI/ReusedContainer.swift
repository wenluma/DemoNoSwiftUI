//
//  ReusedContainer.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/8/31.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

// 提供重用机制
class ReusedContainer<T: Equatable> {
  typealias ReusedFactory = (String) -> T
  
  private var indexSet = IndexSet()
  private var nodes = [T]()
  private var keyFactory = [String: ReusedFactory]()
  func register(factory: @escaping ReusedFactory, for key: String) {
    keyFactory[key] = factory
  }
  
  func element(for key: String) -> T {
    if let index = reuseIndex(for: key) {
      let element = nodes[index]
      indexSet.insert(index)
      return element
    } else {
      let element = create(for: key)
      nodes.append(element)
      indexSet.insert(nodes.count - 1)
      return element
    }
  }
  
  func reset(with element: T) {
    guard let index = nodes.firstIndex(of: element) else {
      fatalError("element must in nodes")
    }
    indexSet.remove(index)
  }
  
  private func create(for key: String) -> T {
    guard let factory = keyFactory[key] else {
      fatalError("need register key = \(key)")
    }
    return factory(key)
  }
  
  private func reuseIndex(for key: String) -> Int? {
    for idx in 0 ..< nodes.count {
      if !indexSet.contains(idx) {
        return idx
      }
    }
    return nil
  }
}

