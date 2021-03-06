//
//  AddressProtocol.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/15.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

protocol OBJAddressProtocol {
    associatedtype Element
    func toRawPointer() -> UnsafeMutableRawPointer
    func log(e: Element)
}

public class MGLObservable<Element> {
    
}

protocol MGLObservableType {
    associatedtype Element
    
    typealias E = Element
    
    func asObservable() -> MGLObservable<Element>
}

//extension OBJAddressProtocol {
//    func toRawPointer() -> UnsafeMutableRawPointer {
//        let pointer = Unmanaged.passUnretained(Self.Type).toOpaque()
//        return pointer
//    }
//}
