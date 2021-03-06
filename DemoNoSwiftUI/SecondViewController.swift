//
//  SecondViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/23.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, ScrollWithZoomProtocol {
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindOutScrollView(outScrollView: UIScrollView) {
    self.outScrollView = outScrollView
  }

  weak var outScrollView: UIScrollView?

  lazy var scrollview: ZoomScrollView = {
    let sv = ZoomScrollView()
    sv.isZoomingReply.subscribe { [weak self] (event) in
      if let self = self, case let .next(isZooming) = event {
        self.outScrollView?.isScrollEnabled = !isZooming
      }
    }
    return sv
  }()
  
  let imgV = UIImageView(image: UIImage(named: "009"))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    LOG_DEBUG()

    view.addSubview(scrollview)
    scrollview.bind(zoomView: imgV)
    imgV.frame = SCREEN_BOUNDS
    
    view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    LOG_DEBUG()
    scrollview.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
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
