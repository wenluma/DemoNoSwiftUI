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
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor : color as Any]
        return NSAttributedString(string: self, attributes: attribute)
    }
}
