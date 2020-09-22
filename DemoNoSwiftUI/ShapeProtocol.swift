//
//  ShapeProtocol.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/22.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

protocol ShapeProtocol {
  func draw()
}

extension ShapeProtocol {
  func draw() {
    print("hello draw...")
  }
}

struct Shape: ShapeProtocol {
}

struct Rect: ShapeProtocol {
  
}

extension Rect {
  func draw() {
    print("rect ...")
  }
}

struct Circle: ShapeProtocol {
  
}

extension Circle {
  func draw() {
    print("circle ...")
  }
}
