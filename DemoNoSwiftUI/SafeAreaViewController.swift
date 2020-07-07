//
//  FrameTransformViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/29.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

/*
 参考链接 ：
 获取安全区域的top，bottom 高度 https://stackoverflow.com/questions/46829840/get-safe-area-inset-top-and-bottom-heights
 iOS 11, iOS 10 顶部，底部布局view https://svasilevkin.wordpress.com/2019/01/11/snapkit-safe-area-and-layout-guide-difference/
 */

class SafeAreaViewController: UIViewController {
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
  
  private lazy var bottomView: UIView = {
    let view = UIView()
    view.backgroundColor = .yellow
    return view
  }()
  
  private lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(topView)
    view.addSubview(bottomView)
    view.addSubview(contentView)
    
    view.setNeedsUpdateConstraints()
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
}
