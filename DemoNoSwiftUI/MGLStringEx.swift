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

// MARK: attribute
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
        let container = YYTextContainer.init()
        container.size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        container.maximumNumberOfRows = numberOfRows

        guard let textLayout = YYTextLayout.init(container: container, text: self) else {
            return CGRect.zero
        }
        
        let rect = textLayout.textBoundingRect
        let width = min(rect.width, maxWidth)// 空格太多的异常问题
        return CGRect(x: rect.origin.x, y: rect.origin.y, width: width, height: rect.height)
        
//        // 系统的高度计算 emoji 表情差的比较多
//        return self.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [NSStringDrawingOptions.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    }
    
    
    /// 输入字符串，获取对应的 size 大小
    /// - Parameters:
    ///   - maxWidth: 设置最大宽度
    ///   - numberOfLines: 行数， 默认0， 代表不限制行数
    /// - Returns: 返回计算后的大小
    func yy_getAttrSize(maxWidth: CGFloat, numberOfLines: UInt = 0) -> CGSize {
        let rect = yy_getAttrRect(maxWidth: maxWidth, numberOfRows: numberOfLines)
        return rect.size
    }
}

// MARK: - sub string by index
//    https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
extension String {
    
    func allRange() -> NSRange {
//        return NSRange(self.startIndex...self.endIndex, in: self)
        return NSMakeRange(0, self.count)
    }
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

// MARK: regular
extension String {
    func isPhone() -> Bool {
        do {
//            let pattern = "+?\\d{3,5} ?-? ?\\d{5,18}"
//            let pattern = "+??[0-9]{3,5}"
            let pattern = "(\\d{5}|\\+?\\d{2,5}( {0,2}-?)(( {0,2}\\d{2,5}){2,5}))"
            let expression = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            let times = expression.numberOfMatches(in: self, options: .reportProgress, range: self.allRange())
            if (times > 0) {
                print("times: \(times)")
                return true
            }
            return false
        } catch {
            fatalError("try failed")
            return false
        }
    }
}

//MARK: - url decode/encode
extension String {
    
    /// string 进行url编码
    /// - Returns: 编码后的string
    func mgl_urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// string 进行url解码
    /// - Returns: 解码后的string
    func mgl_urlDecode() -> String? {
        return self.removingPercentEncoding
    }
    
}
