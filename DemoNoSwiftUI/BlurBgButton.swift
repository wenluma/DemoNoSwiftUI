//
//  BlurBgButton.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/1.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

class BlurBgButton: UIView {
  
  private lazy var blurButtonBg: UIImageView = {
    let imgv = UIImageView()
    imgv.layer.cornerRadius = 20
    imgv.clipsToBounds = true
    imgv.backgroundColor = UIColor.red.withAlphaComponent(0.36)
    
    let blurEffect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    imgv.addSubview(blurView)
    return imgv
  }()
  
  private(set) lazy var button: UIButton = {
    let btn = UIButton(type: .custom)
    btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    return btn
  }()
  
  init(imageName: String) {
    super.init(frame: .zero)
    button.setImage(UIImage(named: imageName), for: .normal)
    addSubview(blurButtonBg)
    addSubview(button)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    blurButtonBg.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    button.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}
