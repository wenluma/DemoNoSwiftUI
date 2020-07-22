//
//  BlurBgButton.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/1.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

fileprivate let BLUR_BUTTON_RADIUS: CGFloat = 20

class BlurBgButton: UIView {
  
  private lazy var blurButtonBg: UIImageView = {
    let imgv = UIImageView()
    imgv.layer.cornerRadius = imgvCornerRadius
    imgv.clipsToBounds = true
    imgv.backgroundColor = UIColor.gray.withAlphaComponent(0.36)

    let blurEffect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    imgv.addSubview(blurView)
    return imgv
  }()

  private lazy var button: UIButton = {
    let btn = UIButton(type: .custom)
    btn.contentEdgeInsets = UIEdgeInsets(top: insertPadding, left: insertPadding, bottom: insertPadding, right: insertPadding)
    return btn
  }()

  private var imgvCornerRadius: CGFloat = 0
  private var insertPadding: CGFloat

  init(imageName: String, cornerRadius: CGFloat = BLUR_BUTTON_RADIUS, insertPadding: CGFloat = 8) {
    imgvCornerRadius = cornerRadius
    self.insertPadding = insertPadding
    super.init(frame: .zero)
    button.setImage(UIImage(named: imageName), for: .normal)
    addSubview(blurButtonBg)
    addSubview(button)
    
    setupConsstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupConsstraints() {
    blurButtonBg.snp.makeConstraints { (make) in
      make.size.equalTo(BLUR_BUTTON_RADIUS*2)
      make.center.equalToSuperview()
    }

    button.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}
extension BlurBgButton {
  var tap: Observable<Void>  {
     return self.button.rx.tap
      .takeUntil(self.rx.deallocated)
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
  }
}
