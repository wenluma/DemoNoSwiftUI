//
//  AddressProtocol.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/15.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

protocol OBJAddressProtocol {
    func toRawPointer() -> UnsafeMutableRawPointer
}

//extension OBJAddressProtocol {
//    func toRawPointer() -> UnsafeMutableRawPointer {
//        let pointer = Unmanaged.passUnretained(Self.Type).toOpaque()
//        return pointer
//    }
//}
