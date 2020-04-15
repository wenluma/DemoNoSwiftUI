//
//  Const.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/11.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

// 声明常量
public let kDuration = 0.3

// 内部可见
private let kVersion = "0.1.0"

let f1 = ceil(0.1) // 1 向上取整
let f2 = floor(0.1) // 0 向下取整

#if os(iOS)
    import UIKit
    typealias OSApplication = UIApplication
#elseif os(macOS)
    import Cocoa
    typealias OSApplication = NSApplication
#endif
