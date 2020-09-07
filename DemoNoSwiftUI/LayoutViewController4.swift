//
//  LayoutViewController4.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/4.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

// 将布局的约束放入superview 中，进行布局依赖
class UserAudioStateView: UIView {
  lazy var nameLabel: UILabel = {
    let lab = UILabel()
    lab.backgroundColor = .yellow
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
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class LayoutViewController4: UIViewController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var smallView: UserAudioStateView = {
    let bigView = UserAudioStateView(frame: .zero)
    return bigView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(smallView)
    view.addSubview(smallView.nameLabel)
    view.addSubview(smallView.audioStateView)
    
    smallView.audioStateView.snp.makeConstraints { (make) in
      make.leading.equalTo(10)
      make.size.equalTo(12)
      make.centerY.equalToSuperview()
    }
    
    smallView.nameLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(smallView.audioStateView.snp.trailing).offset(4)
      make.centerY.equalTo(smallView.audioStateView)
      make.trailing.lessThanOrEqualToSuperview().offset(-10)
    }
    
    smallView.snp.makeConstraints { (make) in
      make.height.equalTo(22)
      make.leading.equalToSuperview()
      make.centerY.equalTo(smallView.audioStateView)
      make.trailing.equalTo(smallView.nameLabel.snp.trailing).offset(10)
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(updateText))
    view.addGestureRecognizer(tap)
    view.setNeedsUpdateConstraints()
  }
  
  var num: Int = 0
  @objc func updateText(tap: UITapGestureRecognizer) {
    num += 1
    if let text = smallView.nameLabel.text {
      smallView.nameLabel.text = String(num) + text

    } else {
      smallView.nameLabel.text = String(num)
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
