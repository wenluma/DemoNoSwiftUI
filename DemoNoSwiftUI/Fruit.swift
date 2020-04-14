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
    init(name: String) {
        self.name = name
    }
}

class Apple: Fruit {
    var address: String
    override init(name: String) {
        address = "china" // 先本类属性，在super 属性
        super.init(name: name)
    }
}
