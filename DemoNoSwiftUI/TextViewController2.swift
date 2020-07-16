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
    lab.font = UIFont.systemFont(ofSize: 17)
    return lab
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let lab = UILabel()
    lab.font = .systemFont(ofSize: 10)
    lab.text = " Max 200 "
    lab.layer.cornerRadius = 4.0
    lab.layer.masksToBounds = true
    lab.textColor = UIColor(red: 135, green: 139, blue: 144)
    lab.backgroundColor = UIColor(red: 135, green: 139, blue: 144).withAlphaComponent(0.2)
    lab.sizeToFit()
    let rect = lab.frame
    lab.frame = CGRect(x: 0, y: 0, width: rect.width, height: 16)

    let img = lab.asImage()
    tailToken = img.toAttributedString(font: UIFont.systemFont(ofSize: 17))

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
    // 添加一个空格，满足需求
    info.append("好 ")
    let mutAttr = NSMutableAttributedString(string: info)
    mutAttr.append(tailToken)
    detail.attributedText = mutAttr
  }
}
