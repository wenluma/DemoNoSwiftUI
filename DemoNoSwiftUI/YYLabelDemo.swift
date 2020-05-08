//
//  YYLabelDemo.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/14.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit
import YYText

func getYYLabel(str: String, font: UIFont = .boldSystemFont(ofSize: 16), maxWidth: CGFloat, lineSpacing: CGFloat = 0.0) -> YYLabel {
    let mutAttributed = NSMutableAttributedString(string: str)
    mutAttributed.yy_font = font
    mutAttributed.yy_lineSpacing = lineSpacing
//    mutAttributed.yy_maximumLineHeight = font.lineHeight + 1

    let rect = mutAttributed.yy_getAttrRect(maxWidth: maxWidth)
    let label = YYLabel()
    label.attributedText = mutAttributed
    label.numberOfLines = 0
    label.frame = rect
//    label.frame = CGRect(x:0, y:0, width: maxWidth, height: 0) 设置之后，居然 frame 0 了，不合理
//    label.sizeToFit()
//    label.sizeThatFits(rect.size)
    
    label.backgroundColor = .orange

    print("|str:\(str) |rect: \(rect) |frame: \(label.frame)")
    return label
}

func getYYLableEmoji(emojiImgName: String, str: String, emojiSize: CGFloat, fontSize: CGFloat = 16, maxWidth: CGFloat = 100) -> YYLabel {
    let emojiImage = UIImage(named: emojiImgName)!
    let emojiAttr = NSMutableAttributedString.yy_attachmentString(
    withEmojiImage: emojiImage, fontSize: emojiSize)!
    
    let attrStr = NSAttributedString(string: str, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])

    let mutAttributed = NSMutableAttributedString(attributedString: emojiAttr)
    mutAttributed.append(attrStr)

    let rect = mutAttributed.yy_getAttrRect(maxWidth: maxWidth)
    
    let label = YYLabel()
    label.attributedText = mutAttributed
    label.sizeToFit()
    label.backgroundColor = .orange
    print("|emoji:\(emojiImage) |str: \(str) |rect: \(rect) |frame: \(label.frame) imgSize:\(emojiSize), fontSize:\(fontSize)")
    return label
}
