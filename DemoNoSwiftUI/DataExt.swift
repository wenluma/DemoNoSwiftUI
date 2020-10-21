//
//  DataExt.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/8/18.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import CommonCrypto
import CryptoKit

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
  
  mutating func MD5() -> String {
    if #available(iOS 13, *) {
      let digest = Insecure.MD5.hash(data: self)
      return digest.map { String(format: "%02hhx", $0) }.joined()
    } else {
      let data = self
      let hash = self.withUnsafeBytes {
        (bytes: UnsafeRawBufferPointer) -> [UInt8] in
          var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
          CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
          return hash
      }
      return hash.map { String(format: "%02x", $0) }.joined()
    }
  }
}
