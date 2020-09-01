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
