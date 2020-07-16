//
//  TextViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/15.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import YYText


class TextViewController: UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let lab = UILabel()
    lab.font = .systemFont(ofSize: 10)
    lab.text = " Max 200 "
    lab.textColor = UIColor(red: 135, green: 139, blue: 144)
    lab.backgroundColor = UIColor(red: 135, green: 139, blue: 144).withAlphaComponent(0.2)

    view.addSubview(lab)
    
    view.addSubview(detail)
    detail.snp.makeConstraints { (make) in
      make.leading.equalTo(20)
      make.top.equalTo(view.snp.centerY).offset(30)
    }
    
    lab.snp.makeConstraints { (make) in
      make.leading.equalTo(detail.snp.trailing).offset(5)
      make.trailing.lessThanOrEqualToSuperview().offset(-20)
      make.centerY.equalTo(detail.snp.centerY)
    }
    
    lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    let tap = UITapGestureRecognizer(target: self, action: #selector(updateText))
    view.addGestureRecognizer(tap)
  }
  
  @objc
  func updateText(tap: UITapGestureRecognizer) {
    var text = detail.text
    text?.append("好")
    detail.text = text
  }
  
  private lazy var detail: YYLabel = {
    let lab = YYLabel()
    lab.numberOfLines = 1
    lab.text = "哈苏的"
    return lab
  }()
  
}
