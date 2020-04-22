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
    
    // fatalError 触发错误
    class func fatatErr() {
        fatalError("message change KimDocsMessageViewModel failed")
    }
    
    // 获取对象的地址 refrence object address
    func toRawPointer() -> UnsafeMutableRawPointer {
        let pointer = Unmanaged.passUnretained(self).toOpaque()
        return pointer
    }
}

extension Fruit: CustomStringConvertible {
    // 动态类型。Self.self
    var description: String {
        return "self: \(Self.self)| name: \(name)"
    }
}

class Apple: Fruit {
    var address: String
    
    // pubic get， private set 非常好
    public private(set) var time: Float32
    
    // public get ，private set， 这个方法666 的
    public private(set) static var stone: Int = 6

//    static var drink : Bool {
//        return false
//    }

    override init(name: String) {
        address = "china" // 先本类属性，在super 属性
        time = 0.5
        super.init(name: name)
    }
    
    // 类方法 的重写， 需要 override
   override static func intro1() -> String {
        print("文件：\(#file) 函数：\(#function) 行：\(#line) 列：\(#column)")
        return "this is apple"
    }
}
