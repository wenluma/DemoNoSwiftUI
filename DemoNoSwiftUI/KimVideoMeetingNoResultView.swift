//
//  CustomView.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/17.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

class KimVideoMeetingNoResultView: UIView {
  
  lazy var iconImageView: UIImageView = {
    let imgV = UIImageView()
    imgV.image = UIImage(named: "video_search")
    return imgV
  }()
  
  lazy var titleLabel: UILabel = {
    let lab = UILabel()
    lab.font = UIFont.systemFont(ofSize: 17)
    lab.textColor = UIColor(red: 84, green: 87, blue: 90)
    return lab
  }()
  
  lazy var guide: UILayoutGuide = {
    let layout = UILayoutGuide()
    return layout
  }()
  
  required init(title: String = "No Result") {
    super.init(frame: .zero)
    setupViews()
    titleLabel.text = title
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    addSubview(iconImageView)
    addSubview(titleLabel)
    addLayoutGuide(guide)
  }
  
  func setupConstraints() {
    guide.snp.makeConstraints { (make) in
      make.height.equalTo(80+36)
      make.width.equalTo(80)
      make.center.equalToSuperview()
    }
    
    iconImageView.snp.makeConstraints { (make) in
      make.top.leading.equalTo(guide)
      make.width.height.equalTo(guide.snp.width)
    }
    
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(iconImageView.snp.bottom).offset(12)
      make.height.equalTo(24)
      make.leading.trailing.equalTo(guide)
    }
  }
}

