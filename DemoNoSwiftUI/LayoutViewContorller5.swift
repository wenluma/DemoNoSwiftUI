//
//  LayoutViewContorller5.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/18.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

// 将布局的约束放入superview 中，进行布局依赖
class AutoHeightView: UIView {
  lazy var nameLabel: UILabel = {
    let lab = UILabel()
    lab.backgroundColor = .yellow
    lab.numberOfLines = 0
    lab.text = "hello"
    lab.font = UIFont.systemFont(ofSize: 12)
    return lab
  }()
  
  lazy var  audioStateView: UIView = {
    let lab = UIView()
    lab.backgroundColor = .red
    return lab
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .green
    
    addSubview(nameLabel)
    nameLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.width.equalTo(175)
      make.centerX.equalToSuperview()
    }
    
    addSubview(audioStateView)
    audioStateView.snp.makeConstraints { (make) in
      make.top.equalTo(nameLabel.snp.bottom).offset(12)
      make.height.equalTo(20)
      make.width.equalTo(100)
      make.bottom.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class LayoutViewContorller5: UIViewController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let ahv = AutoHeightView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(ahv)
    ahv.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.height.greaterThanOrEqualTo(0).priority(.high)
      make.width.equalToSuperview()
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(updateText))
    view.addGestureRecognizer(tap)
    view.setNeedsUpdateConstraints()
  }
  
  var num: Int = 0
  @objc func updateText(tap: UITapGestureRecognizer) {
    guard let c = "UITapGestureRecognizer".randomElement() else {
      return
    }
    if let text = ahv.nameLabel.text {
      ahv.nameLabel.text = text + String(c)
    } else {
      ahv.nameLabel.text = String(c)
    }
    
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
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
