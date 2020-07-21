//
//  RotateViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/13.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//


import UIKit
import SnapKit

/*
 屏幕转屏时，设备转屏，有 faceUp，faceDown 的差异
 */
class RotateViewController: UIViewController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var imgView: UIView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "008")
    return imgView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(imgView)
    view.setNeedsUpdateConstraints()
    
    NotificationCenter.default.addObserver(self, selector: #selector(changeOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    LOG_DEBUG("view.Transform = \(view.transform)")
  }
  
  
  @objc
  func changeOrientation(notification: Notification) {
    if UIDevice.current.orientation.isValidInterfaceOrientation {
      print("isVaild")
    } else {
      print("isInVaild")
    }
    
    switch UIDevice.current.orientation {
      case .portrait:
        print("portrait = 1")
      case .portraitUpsideDown:
      print("portraitUpsideDown = 2")
      case .landscapeLeft:
      print("landscapeLeft = 3")
      case .landscapeRight:
      print("landscapeRight = 4")
      case .faceUp:
      print("faceUp = 5")
      case .faceDown:
      print("faceDown = 6")
      default:
      print("unknow")
    }
    print("app = \(UIApplication.shared.statusBarOrientation.rawValue)")
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    imgView.snp.makeConstraints { (make) in
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
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .allButUpsideDown
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
   
    LOG_DEBUG("coordinator.targetTransform = \(coordinator.targetTransform)")
    LOG_DEBUG("coordinator.fromView = \(coordinator.view(forKey: UITransitionContextViewKey.from))")
    LOG_DEBUG("coordinator.toView = \(coordinator.view(forKey: UITransitionContextViewKey.to))")

//    coordinator.containerView.addSubview(imgView)
//    coordinator.containerView.addSubview(imgView)
//    imgView.snp.remakeConstraints { (make) in
//      make.edges.equalToSuperview()
//    }
    
    coordinator.animate(alongsideTransition: { (context) in
//      self.imgView.frame = context.containerView.frame
    }) { (context) in
//      self.view.addSubview(self.imgView)
//      self.imgView.snp.remakeConstraints { (make) in
//        make.edges.equalToSuperview()
//      }
    }
  }
}

extension UIWindow {
//  https://stackoverflow.com/questions/57965701/statusbarorientation-was-deprecated-in-ios-13-0-when-attempting-to-get-app-ori
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
