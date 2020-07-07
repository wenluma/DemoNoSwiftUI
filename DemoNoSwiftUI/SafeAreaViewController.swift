//
//  FrameTransformViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/29.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

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
    topView.snp.makeConstraints { (make) in
      make.top.equalTo(0)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalTo(0)
    }
    
    bottomView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.bottom.equalTo(0)
      make.leading.trailing.equalTo(0)
    }
    
    contentView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.trailing.equalTo(0)
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
