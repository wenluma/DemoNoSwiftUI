//
//  SwitchUIViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/10.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class SwitchUIViewController: UIViewController {
  

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // https://stackoverflow.com/questions/10348869/change-color-of-uiswitch-in-off-state/19123019
  private lazy var myswitch: UISwitch = {
    let myswitch = UISwitch()
    // on color
    myswitch.onTintColor = .red
    // off color
    myswitch.backgroundColor = .green
    myswitch.layer.cornerRadius = 16.0
    return myswitch
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(myswitch)
    view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    // 针对 safe area 的出来逻辑 iOS 11+
    myswitch.snp.makeConstraints { (make) in
      make.center.equalTo(view.snp.center)
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
