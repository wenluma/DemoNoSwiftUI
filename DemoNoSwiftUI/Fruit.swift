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
    
    func logs() {
        // 可以设定跳步间隔
        for index in stride(from: 1, to: 10, by: 2) {
            print(index)
        }
    }
    
    // 可变数目的参数
    func sum(numbers: Int...) -> Int {
        var sum = 0
        for num in numbers {
            sum += num
        }
        return sum
    }
    
    // 交换左右, 输入必须是 var
    func swap(lhs: inout Int, rhs: inout Int) {
        let tmp = lhs
        lhs = rhs
        rhs = tmp
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

//https://stackoverflow.com/questions/24171814/can-associated-values-and-raw-values-coexist-in-swift-enumeration
//Can associated values and raw values coexist in Swift enumeration?

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

extension Barcode: RawRepresentable {

    public typealias RawValue = String

    /// Failable Initalizer
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "Order 1":  self = .UPCA(1,1,1)
        case "Order 2":  self = .QRCode("foo")
        default:
            return nil
        }
    }

    func invoke(vm: () -> Void) {
        vm()
    }
    
    /// Backing raw value
    public var rawValue: RawValue {
        switch self {
        case .UPCA:     return "Order 1"
        case .QRCode:   return "Order 2"
        }
    }

}
