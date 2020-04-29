//
//  MGLTextInputDemo.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/29.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

func getTextView() -> UITextView {
    let textView = UITextView()
    // 模拟键盘输入, 会使delegate发生调用,插入到文本的尾部，不论 之前是富文本，还是纯文本，都可以
    // 有些会跟delegate text change 绑定关联操作，需要手动，，可以加上个开关，来控制，是否受影响
    textView.insertText("abc")
    return textView
}
