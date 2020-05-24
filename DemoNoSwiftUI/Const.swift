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

let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_WIDTH = SCREEN_BOUNDS.width
let SCREEN_HEIGHT = SCREEN_BOUNDS.height

// 内部可见
private let kVersion = "0.1.0"

let f1 = ceil(0.1) // 1 向上取整
let f2 = floor(0.1) // 0 向下取整

func LOG_DEBUG(file: String = #file, funcname: String = #function, line: Int = #line ,_ message: String = "") {
  let msg = String(file.split(separator: "/").last!) + ", " + funcname + " line:\(line) " + message
  log.debug(msg)
}

#if os(iOS)
    import UIKit
    typealias OSApplication = UIApplication
#elseif os(macOS)
    import Cocoa
    typealias OSApplication = NSApplication
#endif

enum Event<T> {
    case next(T)
    case error(Error)
    case completed
}

func handleEvent() {
    let event = Event.next((1.0, 0))
    
    switch event {
    case let .next((padding, number)):
        print(padding)
        print(number)
    case .error(_): break
    case .completed: break
    }
}

public protocol MGLError: Error {
    
}

extension Error {
    
    public func asMGLError(orFailWith message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> MGLError {
        guard let mglError = self as? MGLError else {
            fatalError(message(), file: file, line: line)
        }
        return mglError
    }
}


