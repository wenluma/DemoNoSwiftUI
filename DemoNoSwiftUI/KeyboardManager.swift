//
//  KeyboardManager.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/8.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
  static let myKeyboardWillShow = Notification.Name("my.keybarod.willShow")
}

/*
 https://stackoverflow.com/questions/26939105/keyboard-animation-curve-as-int
 
 po notification
 ▿ name = UIKeyboardWillChangeFrameNotification,
 object = nil,
 userInfo = Optional([AnyHashable("UIKeyboardFrameBeginUserInfoKey"): NSRect: {{0, 477}, {375, 335}}, AnyHashable("UIKeyboardIsLocalUserInfoKey"): 1,
 AnyHashable("UIKeyboardAnimationCurveUserInfoKey"): 7,
 AnyHashable("UIKeyboardFrameEndUserInfoKey"): NSRect: {{0, 445.33333333333326}, {375, 366.66666666666674}}, AnyHashable("UIKeyboardBoundsUserInfoKey"): NSRect: {{0, 0}, {375, 366.66666666666674}},
 AnyHashable("UIKeyboardCenterEndUserInfoKey"): NSPoint: {187.5, 628.66666666666663}, AnyHashable("UIKeyboardAnimationDurationUserInfoKey"): 0,
 AnyHashable("UIKeyboardCenterBeginUserInfoKey"): NSPoint: {187.5, 644.5}])
 - name : "UIKeyboardWillChangeFrameNotification"
 ▿ userInfo : 8 elements
 ▿ 0 : 2 elements
 ▿ key : AnyHashable("UIKeyboardFrameBeginUserInfoKey")
 - value : "UIKeyboardFrameBeginUserInfoKey"
 - value : NSRect: {{0, 477}, {375, 335}}
 ▿ 1 : 2 elements
 ▿ key : AnyHashable("UIKeyboardIsLocalUserInfoKey")
 - value : "UIKeyboardIsLocalUserInfoKey"
 - value : 1
 ▿ 2 : 2 elements
 ▿ key : AnyHashable("UIKeyboardAnimationCurveUserInfoKey")
 - value : "UIKeyboardAnimationCurveUserInfoKey"
 - value : 7
 ▿ 3 : 2 elements
 ▿ key : AnyHashable("UIKeyboardFrameEndUserInfoKey")
 - value : "UIKeyboardFrameEndUserInfoKey"
 - value : NSRect: {{0, 445.33333333333326}, {375, 366.66666666666674}}
 ▿ 4 : 2 elements
 ▿ key : AnyHashable("UIKeyboardBoundsUserInfoKey")
 - value : "UIKeyboardBoundsUserInfoKey"
 - value : NSRect: {{0, 0}, {375, 366.66666666666674}}
 ▿ 5 : 2 elements
 ▿ key : AnyHashable("UIKeyboardCenterEndUserInfoKey")
 - value : "UIKeyboardCenterEndUserInfoKey"
 - value : NSPoint: {187.5, 628.66666666666663}
 ▿ 6 : 2 elements
 ▿ key : AnyHashable("UIKeyboardAnimationDurationUserInfoKey")
 - value : "UIKeyboardAnimationDurationUserInfoKey"
 - value : 0
 ▿ 7 : 2 elements
 ▿ key : AnyHashable("UIKeyboardCenterBeginUserInfoKey")
 - value : "UIKeyboardCenterBeginUserInfoKey"
 - value : NSPoint: {187.5, 644.5}
 */


// 键盘相关
extension NSNotification {
  private func keyboardValue<T>(for key: String, result: inout T?) {
    guard let userInfo = userInfo,
      let value = userInfo[key],
      let tvalue = value as? T
      else {
        result = nil
        return
    }
    result = tvalue
  }
  
  var kb_endFrame: CGRect? {
    var value: NSValue?
    keyboardValue(for: UIResponder.keyboardFrameEndUserInfoKey, result: &value)
    if let rect = value?.cgRectValue {
      return rect
    }
    return nil
    //    return (userInfo?[UIResponder.keyboardFrameBeginUserInfoKey as AnyHashable] as? NSValue)?.cgRectValue
  }
  
  var kb_startFrame: CGRect? {
    var value: NSValue?
    keyboardValue(for: UIResponder.keyboardFrameBeginUserInfoKey, result: &value)
    if let rect = value?.cgRectValue {
      return rect
    }
    return nil
  }
  
  var kb_duration: TimeInterval? {
    var value: NSNumber?
    keyboardValue(for: UIResponder.keyboardAnimationDurationUserInfoKey, result: &value)
    if let duration = value?.doubleValue {
      return duration
    }
    return nil
  }
  
  var kb_animationCurve: UIView.AnimationOptions? {
    var value: NSNumber?
    keyboardValue(for: UIResponder.keyboardAnimationCurveUserInfoKey, result: &value)
    if let curveRaw = value?.uintValue {
      return  UIView.AnimationOptions(rawValue: curveRaw << 16)
    }
    return UIView.AnimationOptions.curveEaseInOut
  }
  
  var kb_isLocal: Bool? {
    var value: NSNumber?
    keyboardValue(for: UIResponder.keyboardIsLocalUserInfoKey, result: &value)
    if let isLocal = value?.boolValue {
      return isLocal
    }
    return nil
  }
  
  var kb_bounds: CGRect? {
    var value: NSValue?
    keyboardValue(for: UIResponder.keyboardFrameBeginUserInfoKey, result: &value)
    if let rect = value?.cgRectValue {
      return rect
    }
    return nil
  }
}

class KeyboardManager {
    
  weak var view: UIView?
  private let animation: AnimationBlock?
  private let animationDelatY: AnimationDelatYBlock?
  typealias AnimationBlock = (CGRect, CGRect) -> Void
  typealias AnimationDelatYBlock = (CGFloat) -> Void
  init(animation: AnimationBlock? = nil, animationDelatY: AnimationDelatYBlock? = nil) {
    self.animation = animation
    self.animationDelatY = animationDelatY
    
    // will show keyboard
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)

    // will Hide keyboard
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
   
    // did hidden keyboard
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    
    // will change keyboard frame
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }

  @objc
  func keyboardWillShow(notification: NSNotification) {
    LOG_DEBUG()
  }
  
  @objc
  func keyboardDidShow(notification: NSNotification) {
    LOG_DEBUG()
  }
  
  @objc
  func keyboardWillHide(notification: NSNotification) {
    LOG_DEBUG()
  }
  
  @objc
  func keyboardDidHide(notification: NSNotification) {
    LOG_DEBUG()
  }
  
  @objc
  func keyboardWillChangFrame(notification: NSNotification) {
    LOG_DEBUG()
    guard let isLocal = notification.kb_isLocal, isLocal,
      let startFrame = notification.kb_startFrame,
      let endFrame = notification.kb_endFrame,
      let duration = notification.kb_duration,
      let animationOption = notification.kb_animationCurve else {
        return
    }

    print("start:\(startFrame); end:\(endFrame)")
    
    if let block = self.animation {
      block(startFrame, endFrame)
    }
    
    if let block = self.animationDelatY, let view = view {
      if (endFrame.minY - view.bounds.height).isEqual(to: 0) {
        block(0)
      } else {
        block(endFrame.height)
      }
    }
    
    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: animationOption,
      animations: { [weak self] in
        self?.view?.layoutIfNeeded()
    }) { [weak self] (finished) in
      self?.view?.layoutIfNeeded()
    }
    
    //      if let userInfo = notification.userInfo {
    //          let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    //          let endFrameY = endFrame?.origin.y ?? 0
    //          let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
    //          let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
    //          let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
    //          let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
    //          if endFrameY >= UIScreen.main.bounds.size.height {
    //              self.keyboardHeightLayoutConstraint?.constant = 0.0
    //          } else {
    //              self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
    //          }
    //          UIView.animate(withDuration: duration,
    //                                     delay: TimeInterval(0),
    //                                     options: animationCurve,
    //                                     animations: { self.view.layoutIfNeeded() },
    //                                     completion: nil)
    //      }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}
