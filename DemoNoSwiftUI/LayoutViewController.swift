//
//  LayoutViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/10.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

class LayoutViewController: UIViewController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var bigView: UIView = {
    let bigView = UIView()
    bigView.backgroundColor = .green
    return bigView
  }()
  
  private lazy var smallView: UIView = {
    let bigView = UIView()
    bigView.backgroundColor = .red
    return bigView
  }()

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(bigView)
    view.addSubview(smallView)
    view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    // 针对 safe area 的出来逻辑 iOS 11+
    bigView.snp.makeConstraints { (make) in
      make.center.equalTo(view.snp.center)
      make.size.equalTo(100)
    }
    
    smallView.snp.makeConstraints { (make) in
      make.center.equalTo(bigView)
      // small.width = big.width /2
      make.size.equalTo(bigView).dividedBy(2)
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
