//
//  WithoutAnimationViewContronller.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/16.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

/*
 动画终止的方式：
 UIView.setAnimationsEnabled(false)
 UIView.setAnimationsEnabled(true)
 
 UIView.performWithoutAnimation {}
 
 

 */
class WithoutAnimationViewContronller: UIViewController {
  
  private var tailToken: NSAttributedString!
  private var info: String = ""
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private lazy var detail: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(detail)
    detail.snp.makeConstraints { (make) in
      make.size.equalTo(100)
      make.center.equalToSuperview()
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(updateText))
    view.addGestureRecognizer(tap)
  }
  
  @objc
  func updateText(tap: UITapGestureRecognizer) {
    detail.snp.remakeConstraints { (make) in
      make.size.equalTo(150)
      make.center.equalToSuperview()
    }

//    UIView.setAnimationsEnabled(false)
//    UIView.animate(withDuration: 0.25) {
//      self.view.layoutIfNeeded()
//      UIView.setAnimationsEnabled(true)
//    }
    
//   禁止动画的方式
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    CATransaction.setCompletionBlock {
      self.view.layoutIfNeeded()
    }
    CATransaction.commit()
  }
}
