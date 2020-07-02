//
//  FrameTransformViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/29.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit


class FrameTransformViewController: UIViewController, ScrollWithZoomProtocol {
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
    sv.minimumZoomScale = 0.5
    sv.maximumZoomScale = 2.5
    sv.zoomScale = 0.5
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
    view.backgroundColor = .white
    
    let scaleRect = SCREEN_BOUNDS.applying(CGAffineTransform.identity.scaledBy(x: 2, y: 2))
    print("scaleRect = \(scaleRect)")
    
    LOG_DEBUG()

    // 初始化时，要双倍的，在渲染时，进行缩放操作
//    var rect = CGRect(x: 0, y: 0, width: 2 * SCREEN_BOUNDS.width, height: 2 * SCREEN_BOUNDS.height)
//    imgV.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
    imgV.frame = scaleRect
//    imgV.frame = SCREEN_BOUNDS
    
    view.addSubview(scrollview)
    scrollview.bind(zoomView: imgV)
    
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
