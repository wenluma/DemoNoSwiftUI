//
//  CollectionViewContoller.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/23.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation

import UIKit
import SnapKit
import RxSwift
import RxRelay

class CollectionZoomCell: UICollectionViewCell, UIScrollViewDelegate {
  
  lazy var scrollview: ZoomScrollView = {
    let sv = ZoomScrollView()
    sv.backgroundColor = .yellow
    return sv
  }()
    
  lazy var imageView: UIImageView = {
    let imgV = UIImageView()
    return imgV
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(scrollview)
    scrollview.bind(zoomView: imageView)
    imageView.frame = self.bounds
    setNeedsUpdateConstraints()
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    scrollview.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class CollectionViewController: UIViewController,
UICollectionViewDelegate,
UICollectionViewDataSource, UIScrollViewDelegate  {
  var zoomDisposable: Disposable?
  let imgNames = ["008", "009"]
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imgNames.count;
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zoom", for: indexPath) as! CollectionZoomCell
    let img = UIImage(named: imgNames[indexPath.row])
    cell.imageView.image = img
    zoomDisposable?.dispose()
    zoomDisposable = cell.scrollview.isZoomingReply.subscribe { (event) in
      if case let .next(isZooming) = event {
        collectionView.isScrollEnabled = !isZooming
        print("collectionview is scrollEnabled = \(collectionView.isScrollEnabled)")
      }
    }
    
    return cell
  }
  
  lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.itemSize = UIScreen.main.bounds.size
    let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
    cv.delegate = self
    cv.dataSource = self
    cv.delaysContentTouches = false
    cv.bounces = false
    cv.register(CollectionZoomCell.self, forCellWithReuseIdentifier: "zoom")
    cv.backgroundColor = .systemBlue
    cv.isPagingEnabled = true
    return cv
  }()
 
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(collectionView)
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    collectionView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}
