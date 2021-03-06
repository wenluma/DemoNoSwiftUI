//
//  ArrayExt.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/1.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
// 越界check https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
extension Collection {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

extension MutableCollection {
  subscript(safe index: Index) -> Element? {
    get {
      return indices.contains(index) ? self[index] : nil
    }
    
    set(newValue) {
      if let newValue = newValue, indices.contains(index) {
        self[index] = newValue
      }
    }
  }
}

extension Collection {
  static func repeated(initCount: Int, factory: () -> Element) -> [Element] {
    var list = [Element]()
    for _ in 0..<initCount {
      list.append(factory())
    }
   return list
  }
}

enum SwapError: Error {
  case wrongFirstIndex
  case wrongSecondIndex
}

extension Array {
  mutating func detailedSafeSwapAt(_ i: Int, _ j: Int) throws {
    if !(0..<count ~= i) { throw SwapError.wrongFirstIndex }
    if !(0..<count ~= j) { throw SwapError.wrongSecondIndex }
    swapAt(i, j)
  }
  
  @discardableResult mutating func safeSwapAt(_ i: Int, _ j: Int) -> Bool {
    do {
      try detailedSafeSwapAt(i, j)
      return true
    } catch {
      return false
    }
  }
}

public extension Array where Element: Hashable {
  func distinct() -> [Element] {
    var container =  Set<Element>()
    var list = [Element]()
    for item in self {
      if container.contains(item) {
        continue
      }
      container.insert(item)
      list.append(item)
    }
    return list
  }
}
