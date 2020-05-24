//
//  CollectionViewContoller.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/23.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//
/*
 自定义 contain vc
 
 https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html
 
 布局 collectionview  item space
 https://stackoverflow.com/questions/17229350/cell-spacing-in-uicollectionview
 */

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
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    scrollview.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}

class ZoomVCCollectionCell: UICollectionViewCell {
  weak var vc: UIViewController?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindVC(vc: UIViewController & ScrollWithZoomProtocol) {
    contentView.addSubview(vc.view)
    self.vc = vc
    self.vc?.view.frame = self.bounds
  }
}

typealias VCT = (hasAdded: Bool, vc: UIViewController & ScrollWithZoomProtocol)

class CollectionViewController: UIViewController,
//  UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate  {
  var zoomDisposable: Disposable?
  let imgNames = ["008", "009"]
  
  private var isFirstLoad = true
  
  lazy var myvcs: [VCT] = {
    let first = FirstViewController()
    let second = SecondViewController()
    return [(false, first), (false, second)]
  }()

  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return imgNames.count;
    return myvcs.count
  }
  
  func getVC(from indexPath: IndexPath) -> UIViewController {
    myvcs[indexPath.row].vc
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zoom", for: indexPath) as! CollectionZoomCell
//    let img = UIImage(named: imgNames[indexPath.row])
//    cell.imageView.image = img
//    zoomDisposable?.dispose()
//    zoomDisposable = cell.scrollview.isZoomingReply.subscribe { (event) in
//      if case let .next(isZooming) = event {
//        collectionView.isScrollEnabled = !isZooming
//        print("collectionview is scrollEnabled = \(collectionView.isScrollEnabled)")
//      }
//    }

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zoomvc", for: indexPath) as! ZoomVCCollectionCell
    LOG_DEBUG("\(indexPath.row)")

    return cell
  }
  
  var willDisplayIndexPath: IndexPath?
  var endDisplayIndexPath: IndexPath?

  var willDisAppearIndexPath: IndexPath?
  
  
  func bindVCAndDisplay(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    LOG_DEBUG("\(indexPath.row)")

    willDisplayIndexPath = indexPath
    
    let mCell = cell as! ZoomVCCollectionCell
    let vc = myvcs[indexPath.row].vc
    
    self.addChild(vc)
    //... add child vc
    mCell.bindVC(vc: vc)
    
    vc.beginAppearanceTransition(true, animated: false)
    LOG_DEBUG("\(indexPath.row)")
    if isFirstLoad {
      willDisplayIndexPath = nil
      isFirstLoad = false
      vc.didMove(toParent: self)
      vc.endAppearanceTransition()
      LOG_DEBUG("\(indexPath.row)")
    }
  }
  
  override var shouldAutomaticallyForwardAppearanceMethods: Bool {
    return false
  }

  func unbindVCAndDisapper(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    endDisplayIndexPath = indexPath
    let _ = cell as! ZoomVCCollectionCell
    let vc = myvcs[indexPath.row].vc
    
    LOG_DEBUG("\(indexPath.row)")

    vc.beginAppearanceTransition(false, animated: false)

    vc.willMove(toParent: nil)
    // ... child vc remove from superview
    vc.view.removeFromSuperview()
    LOG_DEBUG("\(indexPath.row)")
  }
  
  // will disappear
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    bindVCAndDisplay(collectionView, willDisplay: cell, forItemAt: indexPath)
    LOG_DEBUG("\(indexPath.row)")
  }
  
  // diddisappera
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    unbindVCAndDisapper(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    LOG_DEBUG("\(indexPath.row)")
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    stopScrollView(scrollView: scrollView)
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if (!decelerate) {
      stopScrollView(scrollView: scrollView)
    }
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    let offsetX = scrollView.contentOffset.x + scrollView.center.x
    let offsetY = scrollView.contentOffset.y + scrollView.center.y
    willDisAppearIndexPath = collectionView.indexPathForItem(at: CGPoint(x: offsetX, y: offsetY))
  }

  func stopScrollView(scrollView: UIScrollView) {
    LOG_DEBUG("willindex = \(willDisplayIndexPath), endIndex = \(endDisplayIndexPath)")
    if let willIndexPath = willDisplayIndexPath,
      let attributes = collectionView.layoutAttributesForItem(at: willIndexPath) {
      let toSuperCenter: CGPoint = collectionView.convert(attributes.center, to: collectionView.superview)
      if self.view.frame.contains(toSuperCenter) {
        LOG_DEBUG("is in center")
        let vc = getVC(from: willIndexPath)
        vc.didMove(toParent: self)
        vc.endAppearanceTransition()
      } else {
        LOG_DEBUG("is not in center")
      }
      LOG_DEBUG("\(toSuperCenter)")
    }
    
    if let endIndex = endDisplayIndexPath,
      let attributes = collectionView.layoutAttributesForItem(at: endIndex) {
      let toSuperCenter: CGPoint = collectionView.convert(attributes.center, to: collectionView.superview)
      let vc = getVC(from: endIndex)
      
      if self.view.frame.contains(toSuperCenter) {
        LOG_DEBUG("is in center")
        vc.removeFromParent()
        vc.endAppearanceTransition()
      } else {
        LOG_DEBUG("is not in center")
      }
      LOG_DEBUG("\(toSuperCenter)")
    }
  }

  lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.itemSize = UIScreen.main.bounds.size
//    flowLayout.minimumInteritemSpacing = 0
    flowLayout.minimumLineSpacing = 0
//    flowLayout.sectionInset = .zero
    let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
    cv.delegate = self
    cv.dataSource = self
    cv.delaysContentTouches = false
    cv.bounces = false
    cv.register(CollectionZoomCell.self, forCellWithReuseIdentifier: "zoom")
    cv.register(ZoomVCCollectionCell.self, forCellWithReuseIdentifier: "zoomvc")
    cv.isPrefetchingEnabled = false

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
