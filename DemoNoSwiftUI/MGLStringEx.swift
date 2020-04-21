//
//  MGLStringEx.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/11.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit
import YYText

extension String {
    func toAttribute(color: UIColor) -> NSAttributedString {
//        let ranage = NSRange(location: 0, length: self.count) // 获取字符串的range
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor : color as Any,
                                                        NSAttributedString.Key.baselineOffset: 0 as Any] // -1 向下， 1 上
        
        return NSAttributedString(string: self, attributes: attribute)
    }
    
    func isContainChinese() -> Bool {
        let string = self as NSString
        for index in 0..<string.length {
            let char = string.character(at: index)
            if char > 0x4e00 && char < 0x9fff {
                return true
            }
        }
        return false
    }

    func isChinese() -> Bool {
        let format = "SELF matches %@"
        let match = "(^[\\u4e00-\\u9fa5]+$)"
        let predicate = NSPredicate.init(format: format, argumentArray: [match])
        return predicate.evaluate(with: self)
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view),
            let to = range.upperBound.samePosition(in: utf16view)
        {
            return NSMakeRange(
                utf16view.distance(from: utf16view.startIndex, to: from),
                utf16view.distance(from: from, to: to))
        } else {
            return NSMakeRange(0, 0)
        }

    }

    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(
                utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }
        return from..<to
    }
}

extension NSAttributedString {
   // yylabel 使用时
    func yy_getAttrRect(maxWidth: CGFloat, numberOfRows: UInt = 0) -> CGRect {
        if (self.length < 1) {
            return CGRect.zero
        }
        // YYLabel 的高度计算， emoji 表情的比较准
//        let container = YYTextContainer.init()
//        container.size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
//        container.maximumNumberOfRows = numberOfRows
//
//        guard let textLayout = YYTextLayout.init(container: container, text: self) else {
//            return CGRect.zero
//        }
//        return textLayout.textBoundingRect
        
        // 系统的高度计算 emoji 表情差的比较多
        return self.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [NSStringDrawingOptions.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    }
}

//    https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
extension String {
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
//    let s = "hello"
//    s[0..<3] // "hel"
//    s[3...]  // "lo"
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
      let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
      let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
      return String(self[startIndex...endIndex])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}

