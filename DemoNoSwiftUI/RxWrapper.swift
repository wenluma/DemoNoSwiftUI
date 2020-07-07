//
//  RxWrapper.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/4.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

@propertyWrapper
class RxWrapper<Value, RxType> {
  var wrappedValue: Value
  init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
  
//  var pro
}
