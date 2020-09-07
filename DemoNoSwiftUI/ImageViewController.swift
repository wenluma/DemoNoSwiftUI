//
//  ImageViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/7.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class EdgeView: UIView {
  var edge: UIEdgeInsets
  let contentView: UIView?
  
  required init(contentView: UIView?, edge: UIEdgeInsets) {
    self.edge = edge
    self.contentView = contentView
    super.init(frame: .zero)
    contentView.map({ addSubview($0) })
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if let contentView = contentView {
      let insert = bounds.inset(by: edge)
      contentView.frame = insert
    }
  }
}


class ImageViewController: UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    LOG_DEBUG()
    
    view.backgroundColor = .gray

    let imgV = UIImageView(image: UIImage(named: "008"))
    let edgeView = EdgeView(contentView: imgV, edge: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    edgeView.backgroundColor = .red
    view.addSubview(edgeView)
    edgeView.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.size.equalTo(80)
    }
    view.setNeedsUpdateConstraints()
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
