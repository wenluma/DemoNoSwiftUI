//
//  InputViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/7.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

/*
 参考链接 ：
 获取安全区域的top，bottom 高度 https://stackoverflow.com/questions/46829840/get-safe-area-inset-top-and-bottom-heights
 iOS 11, iOS 10 顶部，底部布局view https://svasilevkin.wordpress.com/2019/01/11/snapkit-safe-area-and-layout-guide-difference/
 */

fileprivate let kBarHeight: CGFloat = 44

class InputViewController: UIViewController {
  
  private var keyboardBottom: Constraint?
  
  private lazy var textField: UITextField = {
    let field = UITextField()
    field.backgroundColor = .cyan
    return field
  }()
  
  private lazy var keyboardManager: KeyboardManager = {
//    let manager = KeyboardManager(animation: { [weak self] (start, end) in
//      guard let self = self else { return }
//      var delatY = 0
//      if start.minY < end.minY {
//        // endY - startY > 0; hidden keyboard
//        delatY = 0
//      } else {
//        // show keyboard
//        delatY = Int(end.height - self.view.safeAreaInsets.bottom) + kBarHeight
//      }
//      self.keyboardBottom?.update(inset: max(delatY, kBarHeight))
//    }) { [weak self] (delatY) in
//      guard let self = self else { return }
//      self.keyboardBottom?.update(inset: max(delatY, CGFloat(kBarHeight)))
//    }
    
    let manager = KeyboardManager { [weak self] (delatY) in
      guard let self = self else { return }
      let height =  max(delatY, 0) + kBarHeight
      self.keyboardBottom?.update(offset: height)
    }
    
    return manager
  }()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private lazy var topView: UIView = {
    let view = UIView()
    view.backgroundColor = .purple
    return view
  }()
  
  // bottom safe area view
  private lazy var bottomView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()

  // 键盘 bar 容器
  private lazy var bottomContentView: UIView = {
    let view = UIView()
    view.backgroundColor = .brown
    return view
  }()
  
  // 键盘 bar
  private lazy var bottomBar: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  private lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }()
  
  private lazy var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(topView)
    view.addSubview(bottomView)
    view.addSubview(contentView)
    
    view.addSubview(bottomContentView)
    bottomContentView.addSubview(bottomBar)
    
    view.addSubview(textField)
    
    view.addGestureRecognizer(tap)
    view.setNeedsUpdateConstraints()
    
    keyboardManager.view = view
//    print(self.keyboardManager.self)
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    // 针对 safe area 的出来逻辑 iOS 11+
    
    // 顶部安全区域，获取 顶部高度
    topView.snp.makeConstraints { (make) in
      make.top.equalTo(0)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalTo(0)
    }
    
    // 底部安全区域，获得高度
    bottomView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.bottom.equalTo(0)
      make.leading.trailing.equalTo(0)
    }
    
    // 中间内容区域
    contentView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.trailing.equalTo(0)
    }
    
    bottomBar.snp.makeConstraints { (make) in
      make.leading.trailing.equalTo(0)
      make.top.equalToSuperview()
      make.height.equalTo(kBarHeight)
    }
    
    bottomContentView.snp.makeConstraints { (make) in
      make.bottom.equalTo(bottomView.snp.top)
      self.keyboardBottom = make.height.equalTo(kBarHeight).constraint
      make.leading.trailing.equalTo(0)
    }
    
    textField.snp.makeConstraints { (make) in
      make.centerY.equalTo(view.snp.centerY).multipliedBy(0.5)
      make.leading.equalTo(10)
      make.trailing.equalTo(-10)
      make.height.equalTo(44)
    }
    
    //
    if #available(iOS 11.0, *) {
      // let window = UIApplication.shared.keyWindow
      // 顶部高度
      let topPadding = view.safeAreaInsets.top
      // 底部高度
      let bottomPadding = view.safeAreaInsets.bottom
      print("topPadding = \(topPadding)")
      print("bottomPadding = \(bottomPadding)")
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    LOG_DEBUG()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    LOG_DEBUG()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    LOG_DEBUG()
  }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    LOG_DEBUG()
  }
  
  @objc
  func hiddenKeyboard() {
    textField.resignFirstResponder()
  }
  
//  override var inputAccessoryView: UIView? {
//    LOG_DEBUG("self.isFrist = \(self.isFirstResponder)")
//    return bottomBar
//  }
//
//  override var canBecomeFirstResponder: Bool {
//    LOG_DEBUG()
//    return true
//  }

}
