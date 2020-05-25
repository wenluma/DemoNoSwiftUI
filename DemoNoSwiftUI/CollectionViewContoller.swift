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
  UICollectionViewDelegate,
  UICollectionViewDataSource,
UIScrollViewDelegate  {
  
  struct LifyCycleRecord {
    var start: IndexPath?
    var appear: IndexPath?
    var disappear: IndexPath?
    var end: IndexPath?
    var enabled: Bool?
    var isFirstLoad: Bool = true
    
    // except isFirstLoa ,reset others
    mutating func reset() {
      start = nil
      appear = nil
      disappear = nil
      end = nil
      enabled = nil
    }
  }
  
  var zoomDisposable: Disposable?
  let imgNames = ["008", "009"]
  
  private var record: LifyCycleRecord = LifyCycleRecord()
  
  lazy var myvcs: [VCT] = {
    let first = FirstViewController()
    let second = SecondViewController()
    return [(false, first), (false, second)]
  }()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    return imgNames.count;
    return myvcs.count
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
  
  func bindVCAndDisplay(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if record.isFirstLoad {
      record.isFirstLoad = false
      let mCell = cell as! ZoomVCCollectionCell
      let vc = myvcs[indexPath.row].vc
      self.addChild(vc)
      //... add child vc
      mCell.bindVC(vc: vc)
      vc.beginAppearanceTransition(true, animated: false)
      LOG_DEBUG("\(indexPath.row)")
      vc.didMove(toParent: self)
      vc.endAppearanceTransition()
      LOG_DEBUG("\(indexPath.row)")
    } else {
      record.enabled = true
      record.appear = indexPath
    }
  }
  
  override var shouldAutomaticallyForwardAppearanceMethods: Bool {
    return false
  }
  
  func unbindVCAndDisapper(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    record.disappear = indexPath
    record.enabled = false
//    let _ = cell as! ZoomVCCollectionCell
//    let vc = myvcs[indexPath.row].vc
//
//    vc.beginAppearanceTransition(false, animated: false)
//    vc.willMove(toParent: nil)
//    // ... child vc remove from superview
//    vc.view.removeFromSuperview()
    
  }
  
  // will disappear
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    bindVCAndDisplay(collectionView, willDisplay: cell, forItemAt: indexPath)
  }
  
  // diddisappear
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    unbindVCAndDisapper(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    stopScrollView(scrollView: scrollView)
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if (!decelerate) {
      stopScrollView(scrollView: scrollView)
    }
  }
  
  private func currentIndexPath(of collectionView: UICollectionView) -> IndexPath? {
    let offsetX = collectionView.contentOffset.x + collectionView.center.x
    let offsetY = collectionView.contentOffset.y + collectionView.center.y
    return collectionView.indexPathForItem(at: CGPoint(x: offsetX, y: offsetY))
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    record.start = currentIndexPath(of :scrollView as! UICollectionView)
  }
  
  func stopScrollView(scrollView: UIScrollView) {
    record.end = currentIndexPath(of: scrollView as! UICollectionView)
    
    record.reset()
    if let willIndexPath = record.appear,
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
    
    if let endIndex = record.end,
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
  
  private func getVC(from indexPath: IndexPath) -> UIViewController {
    myvcs[indexPath.row].vc
  }
  
  private func getVC(from collectionView: UICollectionView) -> UIViewController {
    let indexPath = currentIndexPath(of: collectionView)!
    return getVC(from: indexPath)
  }
  
  
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
