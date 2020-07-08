//
//  KeyboardManager.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/8.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit
#if canImport(RxSwift)
import RxSwift
import RxCocoa
#endif

// 键盘相关
fileprivate extension NSNotification {
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
      return  UIView.AnimationOptions(rawValue: UInt(curveRaw << 16))
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
  // animation 更精细的控制
  private let animation: AnimationBlock?
  // 简单控制， y 的变化，与 animation 互斥，只会执行一个
  private let animationDelatY: AnimationDiffBlock?
  typealias AnimationBlock = (CGRect, CGRect) -> Void
  typealias AnimationDiffBlock = (CGFloat) -> Void
  
  #if canImport(RxSwift)
  // 键盘的height
  let publishDiff: PublishRelay<CGFloat> = PublishRelay()
  // startFrame, endFrame
  let publishDetail: PublishRelay<(CGRect, CGRect)> = PublishRelay()
  #endif
  
  init(animation: AnimationBlock? = nil, animationDelatY: AnimationDiffBlock? = nil) {
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
    
    if let view = view {
      let diff = (endFrame.minY - view.bounds.height).isEqual(to: 0) ? 0 : endFrame.height
      if let block = self.animationDelatY {
        block(diff)
      } else if let block = self.animation {
        block(startFrame, endFrame)
      }
      publishDiff.accept(diff)
    }
    publishDetail.accept((startFrame, endFrame))

    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: animationOption,
      animations: { [weak self] in
        self?.view?.layoutIfNeeded()
    }) { [weak self] (finished) in
      self?.view?.layoutIfNeeded()
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}
