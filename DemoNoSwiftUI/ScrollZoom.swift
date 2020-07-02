//
//  ScrollZoom.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/23.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit
import RxRelay
/// zoom delegate

fileprivate class ScrollZoom: NSObject, UIScrollViewDelegate {
  
  weak var zoomView: UIView?
  weak var myScrollView: UIScrollView?
  weak var otherDelegate: UIScrollViewDelegate?
  
  let myZoomScale: CGFloat = 0.5
  
  private(set) var isZoomingReply: BehaviorRelay = BehaviorRelay(value: false)
  
  convenience init(scrollView: UIScrollView) {
    self.init(zoomView: nil, scrollView: scrollView, scrollViewDelegate: nil)
  }
  
  required init(zoomView: UIView?, scrollView: UIScrollView?, scrollViewDelegate: UIScrollViewDelegate?) {
    self.zoomView = zoomView
    self.myScrollView = scrollView
    self.otherDelegate = scrollViewDelegate
    super.init()
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    if zoomView != nil {    
      print(zoomView!)
    }
    return zoomView
  }
  
  func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    print("begin: \(zoomView!)")
  }
  
  func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    print("scale: \(scale)")
    print("end: \(zoomView!)")
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    print("zoom: \(scrollView.zoomScale)")
//    zoomView?.transform = CGAffineTransform.identity.scaledBy(x: scrollView.zoomScale, y: scrollView.zoomScale)
    print("zoom: \(zoomView!)")
    if let other = otherDelegate {
      other.scrollViewDidZoom?(scrollView)
    }
    
    let isZooming = !scrollView.zoomScale.isEqual(to: scrollView.minimumZoomScale)
    print("isZooming: \(isZooming)")
    isZoomingReply.accept(isZooming)
  }
}

class ZoomScrollView: UIScrollView {
  weak var zoomView: UIView?
//  var wC, hC: Constraint?

  private lazy var zoomDelegate: ScrollZoom = {
    return ScrollZoom(scrollView: self)
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.minimumZoomScale = 0.5
    self.maximumZoomScale = 2.5
    self.delegate = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // frame 模式下
  func bind(zoomView: UIView, autolayout: Bool = false) {
    addSubview(zoomView)
    zoomDelegate.zoomView = zoomView
    
    if autolayout {
//      let w = UIScreen.main.bounds.width
//      let h = UIScreen.main.bounds.height
//      zoomView.snp.makeConstraints { (make) in
//        wC = make.width.equalTo(w).constraint
//        hC = make.height.equalTo(h).constraint
//      }
    }
  }
  
  override var delegate: UIScrollViewDelegate? {
    set {
      super.delegate = zoomDelegate
      zoomDelegate.otherDelegate = newValue
    }
    get {
      super.delegate
    }
  }
  
  var isZoomingReply: BehaviorRelay<Bool> {
    get {
      return self.zoomDelegate.isZoomingReply
    }
  }
  
}
