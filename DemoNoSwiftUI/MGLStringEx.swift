//
//  MGLStringEx.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/11.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func toAttribute(color: UIColor) -> NSAttributedString {
        let ranage = NSRange(location: 0, length: self.count) // 获取字符串的range
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor : color as Any,
                                                        NSAttributedString.Key.baselineOffset: 0 as Any] // -1 向下， 1 上
        
        return NSAttributedString(string: self, attributes: attribute)
    }
}
