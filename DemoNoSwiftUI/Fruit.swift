//
//  Fruit.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/14.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

class Fruit {
    private let name: String
    static var drink: Bool = true // 类属性，不能被继承重写
    init(name: String) {
        self.name = name
    }
    // 类方法 static class 是一样的效果
    static func intro() -> String {
        return "this is fruit"
    }
    // 类方法
    class func intro1() -> String {
        return "this is fruit2"
    }
}

class Apple: Fruit {
    var address: String
    
//    static var drink : Bool {
//        return false
//    }

    override init(name: String) {
        address = "china" // 先本类属性，在super 属性
        super.init(name: name)
    }
    
    // 类方法 的重写， 需要 override
   override static func intro1() -> String {
        return "this is apple"
    }
}
