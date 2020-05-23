//
//  FirstViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/23.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var scrollview: ZoomScrollView = {
    let sv = ZoomScrollView()
    return sv
  }()
  
  let imgV = UIImageView(image: UIImage(named: "008"))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    log.debug(#file, #function)
    view.addSubview(scrollview)
    scrollview.bind(zoomView: imgV)
    imgV.frame = SCREEN_BOUNDS
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    log.debug(#file, #function)
    scrollview.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    log.debug(#file, #function)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    log.debug(#file, #function)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    log.debug(#file, #function)
  }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    log.debug(#file, #function)
  }
}
