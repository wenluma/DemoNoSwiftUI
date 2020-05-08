//
//  KeyboardManager.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/8.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

class KeyboardManager {
    // pubic get, private set
    private(set) var inputView: UIInputView?
    
    init(inputView: UIInputView) {
        self.inputView = inputView
        
        // will show keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // will Hide keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        
    }
}
