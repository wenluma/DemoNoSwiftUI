//
//  RotateViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/13.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//


import UIKit
import SnapKit

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
    
    coordinator.animate(alongsideTransition: { (context) in
      
    }) { (context) in
      
    }
  }
}
