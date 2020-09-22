//
//  ShadowViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/19.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

// 阴影
class ShadowViewController: UIViewController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let ahv = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(ahv)
    // 不能开裁剪，否则，没有阴影效果
//    ahv.clipsToBounds = true
    ahv.backgroundColor = .gray
    
    ahv.layer.shadowColor = UIColor.red.cgColor
    ahv.layer.shadowOpacity = 1
    ahv.layer.shadowOffset = CGSize(width: 0, height: 4)
    ahv.layer.shadowRadius = 12
    // 以下是优化操作
//    ahv.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100)).cgPath
//    ahv.layer.shouldRasterize = true
//    ahv.layer.rasterizationScale = UIScreen.main.scale

    
    ahv.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.size.equalTo(100)
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(updateText))
    view.addGestureRecognizer(tap)
    view.setNeedsUpdateConstraints()
  }
  
  var num: Int = 0
  @objc func updateText(tap: UITapGestureRecognizer) {
    
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
