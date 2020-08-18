//
//  DataExt.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/8/18.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
// https://stackoverflow.com/questions/39075043/how-to-convert-data-to-hex-string-in-swift/39075044
// data to hex string
extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
