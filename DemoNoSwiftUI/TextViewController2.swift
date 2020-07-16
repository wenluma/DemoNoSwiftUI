//
//  TextViewController2.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/16.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class TextViewController2: UIViewController {
  
  private var tailToken: NSAttributedString!
  private var info: String = ""
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private lazy var detail: UILabel = {
    let lab = UILabel()
    lab.numberOfLines = 0
    return lab
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let lab = UILabel()
    lab.font = .systemFont(ofSize: 10)
    lab.text = " Max 200 "
    lab.textColor = UIColor(r: 135, g: 139, b: 144, a: 1.0)
    lab.backgroundColor = UIColor(r: 135, g: 139, b: 144, a: 0.2)
    lab.sizeToFit()

    let img = lab.asImage()
    tailToken = img.toAttributedString()

    view.addSubview(detail)
    detail.snp.makeConstraints { (make) in
      make.leading.equalTo(20)
      make.trailing.equalTo(-20)
      make.top.equalTo(view.snp.centerY).offset(30)
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(updateText))
    view.addGestureRecognizer(tap)
  }
  
  @objc
  func updateText(tap: UITapGestureRecognizer) {
    info.append("好")
    let mutAttr = NSMutableAttributedString(string: info)
    mutAttr.append(tailToken)
    detail.attributedText = mutAttr
  }
}