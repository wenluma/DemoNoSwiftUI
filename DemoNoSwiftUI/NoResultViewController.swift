//
//  File.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/17.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

class NoResultViewController: UIViewController {
  
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private lazy var detail: KimVideoMeetingNoResultView = {
    let noResult = KimVideoMeetingNoResultView()
    return noResult
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    view.addSubview(detail)
    detail.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  

}
