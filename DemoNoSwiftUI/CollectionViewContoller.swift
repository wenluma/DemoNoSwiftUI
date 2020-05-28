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
  
  struct ScrollTrackRecord {
    var start: IndexPath?
    var appear: IndexPath?
    var disappear: IndexPath?
    var end: IndexPath?
    
    var enabled: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    var isFirstLoad: Bool = true
    
    // except isFirstLoad, enabled  ,reset others
    mutating func reset() {
      start = nil
      appear = nil
      disappear = nil
      end = nil
    }
    
    func isChanged() -> Bool {
      guard let start = start, let disappear = disappear else {
        return false
      }
      return start == disappear
    }
  }
  
  var zoomDisposable: Disposable?
  let imgNames = ["008", "009"]

  private lazy var record: ScrollTrackRecord = {
    let recordItem = ScrollTrackRecord()
    recordItem.enabled.subscribe { [weak self]  (event) in
      guard let self = self,
        case let .next(enabled) = event,
        enabled != nil,
        let appearIndexPath = self.record.appear,
        let startIndexPath = self.record.start
      else{
        return
      }
      
      func willAppear(vc: UIViewController) {
        vc.beginAppearanceTransition(true, animated: false)
      }
      
      func didAppear(vc: UIViewController) {
        self.addChild(vc)
        vc.didMove(toParent: self)
        vc.endAppearanceTransition()
      }
      
      func willDisappear(vc: UIViewController) {
        vc.beginAppearanceTransition(false, animated: false)
      }
      
      func didDisappear(vc: UIViewController) {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
        vc.endAppearanceTransition()
      }
      
      let startVC = self.getVC(from: startIndexPath)
      let appearVC = self.getVC(from: appearIndexPath)
      
      if enabled == true {
        willDisappear(vc: startVC)
        willAppear(vc: appearVC)
      } else {
        if self.record.isChanged() {
          didAppear(vc: appearVC)
          didDisappear(vc: startVC)
        } else {
          willAppear(vc: startVC)
          willDisappear(vc: appearVC)
          didAppear(vc: startVC)
          didDisappear(vc: appearVC)
        }
      }
    }
    return recordItem
  }()
  
  lazy var myvcs: [VCT] = {
    let first = FirstViewController()
    let second = SecondViewController()
    return [(false, first), (false, second)]
  }()
  
//  MARK: - collection view data source
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    return imgNames.count;
    return myvcs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zoomvc", for: indexPath) as! ZoomVCCollectionCell
    let vc = myvcs[indexPath.row].vc
    cell.bindVC(vc: vc)
    return cell
  }
//  MARK: collectionview delegate willappear, disappear
  // will disappear
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    bindVCAndDisplay(collectionView, willDisplay: cell, forItemAt: indexPath)
  }
  
  // diddisappear
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    unbindVCAndDisapper(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
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
      record.appear = indexPath
      record.enabled.accept(true)
    }
  }
  
  func unbindVCAndDisapper(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    record.disappear = indexPath
    record.enabled.accept(false)
    record.appear = nil
    record.disappear = nil
  }
  
// MARK: scrollview delegate
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    record.start = currentIndexPath(of :scrollView as! UICollectionView)
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

  func stopScrollView(scrollView: UIScrollView) {
    record.end = currentIndexPath(of: scrollView as! UICollectionView)
  }
  
//  MARK: - view controller
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
  
  override var shouldAutomaticallyForwardAppearanceMethods: Bool {
    return false
  }

  /// https://stackoverflow.com/questions/26357162/how-to-force-view-controller-orientation-in-ios-8
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//    可以引入变量，判断，转屏的方式
//    UIViewController.attemptRotationToDeviceOrientation()
    return .allButUpsideDown
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
}
