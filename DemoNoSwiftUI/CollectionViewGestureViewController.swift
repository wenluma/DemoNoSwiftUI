//
//  CollectionViewGestureViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/31.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

/// 支持缩放的 collection view cell
class KimZoomCollectionCell: UICollectionViewCell {
  weak var child: UIView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(child: UIView) {
    contentView.addSubview(child)
    self.child = child
    child.frame = self.bounds
    
//    if let zoomScrollView = (child as) {
//      zoomScrollView.zoomView?.frame = self.bounds
//      zoomScrollView.contentSize = self.bounds.size
//    }
  }
}

class GestureView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .red
    addSubview(imgV)
    addGestures()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imgV.frame = bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  @objc
  func tapAction(_ tap: UITapGestureRecognizer) {
    print("tap...")
  }
  
  @objc
  func swipeAction(_ swipe: UISwipeGestureRecognizer) {
    print("swipe...")
  }
  
  @objc
  func panAction(_ pan: UIPanGestureRecognizer) {
    print("pan...")
  }

  lazy var tap: UITapGestureRecognizer = {
    UITapGestureRecognizer(target: self, action: #selector(tapAction))
  }()
  
  lazy var swipe: UISwipeGestureRecognizer = {
    UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
  }()
  
  lazy var pan: UIPanGestureRecognizer = {
    UIPanGestureRecognizer(target: self, action: #selector(panAction))
  }()
  
  lazy var imgV: UIImageView = { UIImageView(image: UIImage(named: "008")) }()
  
  func addGestures() {
    self.addGestureRecognizer(tap)
    self.addGestureRecognizer(swipe)
    self.addGestureRecognizer(pan)
  }
}

class CollectionViewGestureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zoomview", for: indexPath) as! KimZoomCollectionCell
    let view = childs[indexPath.row]
    cell.bind(child: view)
    return cell
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 0
    flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
    cv.delaysContentTouches = false
    cv.bounces = false
    cv.register(KimZoomCollectionCell.self, forCellWithReuseIdentifier: "zoomview")
    cv.isPrefetchingEnabled = false
    cv.backgroundColor = .black
    cv.isPagingEnabled = true
    cv.delegate = self
    cv.dataSource = self
    return cv
  }()
  
  private lazy var childs: [UIView] = {
    let v1 = UIView()
    v1.backgroundColor = .gray
    
    let v2 = GestureView(frame: .zero)
    v2.backgroundColor = .red
    
    v2.tap.delegate = self
    v2.pan.delegate = self
    v2.swipe.delegate = self
    
    return [v1, v2]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}

extension CollectionViewGestureViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return true
  }

  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
