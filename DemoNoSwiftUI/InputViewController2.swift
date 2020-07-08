//
//  InputViewController2.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/8.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

/*
 参考链接 ：
 获取安全区域的top，bottom 高度 https://stackoverflow.com/questions/46829840/get-safe-area-inset-top-and-bottom-heights
 iOS 11, iOS 10 顶部，底部布局view https://svasilevkin.wordpress.com/2019/01/11/snapkit-safe-area-and-layout-guide-difference/
 
 距离底部有一定间距，键盘弹起是，同步改变；减去安全区域
  */

fileprivate let kOffset: CGFloat = 30

class InputViewController2: UIViewController {
  
  private var keyboardBottom: Constraint?
  
  private lazy var textField: UITextField = {
    let field = UITextField()
    field.backgroundColor = .cyan
    return field
  }()
  
  private lazy var keyboardManager: KeyboardManager = {
    let manager = KeyboardManager()
    manager.publishDiff.takeUntil(self.rx.deallocated).bind { [weak self] (diff) in
      guard let self = self else { return }
      let height = max(diff - self.view.safeAreaInsets.bottom, 0) + kOffset
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

  // bottom safe area view
  private lazy var bottomView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  private lazy var bottomHeightGuide: UILayoutGuide = {
    let guide = UILayoutGuide()
    return guide
  }()
  
  private lazy var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(bottomView)
    view.addSubview(textField)
    view.addLayoutGuide(bottomHeightGuide)
    
    view.addGestureRecognizer(tap)
    view.setNeedsUpdateConstraints()
    
    keyboardManager.view = view
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    // 针对 safe area 的出来逻辑 iOS 11+

    bottomHeightGuide.snp.makeConstraints { (make) in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.trailing.equalToSuperview()
      self.keyboardBottom = make.height.equalTo(kOffset).constraint
    }
    
    // 底部安全区域，获得高度
    bottomView.snp.makeConstraints { (make) in
      make.bottom.equalTo(bottomHeightGuide.snp.top)
      make.height.equalTo(44)
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

}
