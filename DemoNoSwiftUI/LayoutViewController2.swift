//
//  LayoutViewController2.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/8/26.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

class LayoutViewController2: UIViewController {

  let edgeGuide = UILayoutGuide()
  var girdGuides = [UILayoutGuide]()
  var girdMembers = [UIView]()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    for _ in 0...3 {
      let renderView = UIView()
      girdMembers.append(renderView)
      
      let layoutGuide = UILayoutGuide()
      girdGuides.append(layoutGuide)
    }
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupLayoutGuide() {
    
    view.addLayoutGuide(edgeGuide)
    edgeGuide.snp.makeConstraints { (make) in
      make.leading.equalTo(10)
      make.trailing.equalTo(-10)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    
    let g0 = girdGuides[0]
    let g1 = girdGuides[1]
    let g2 = girdGuides[2]
    let g3 = girdGuides[3]
    view.addLayoutGuide(g0)
    view.addLayoutGuide(g1)
    view.addLayoutGuide(g2)
    view.addLayoutGuide(g3)
    
    g0.snp.makeConstraints { (make) in
      make.leading.equalTo(edgeGuide.snp.leading)
      make.top.equalTo(edgeGuide.snp.top)
      make.width.equalTo(edgeGuide).dividedBy(2)
      make.height.equalTo(edgeGuide).dividedBy(2)
    }
    
    g1.snp.makeConstraints { (make) in
      make.trailing.equalTo(edgeGuide.snp.trailing)
      make.top.equalTo(edgeGuide.snp.top)
      make.width.equalTo(edgeGuide).dividedBy(2)
      make.height.equalTo(edgeGuide).dividedBy(2)
    }
    
    g2.snp.makeConstraints { (make) in
      make.leading.equalTo(edgeGuide.snp.leading)
      make.bottom.equalTo(edgeGuide.snp.bottom)
      make.width.equalTo(edgeGuide).dividedBy(2)
      make.height.equalTo(edgeGuide).dividedBy(2)
    }
    
    g3.snp.makeConstraints { (make) in
      make.trailing.equalTo(edgeGuide.snp.trailing)
      make.bottom.equalTo(edgeGuide.snp.bottom)
      make.width.equalTo(edgeGuide).dividedBy(2)
      make.height.equalTo(edgeGuide).dividedBy(2)
    }
  }
  
  func setupGirdViews() {
    for index in 0 ..< girdGuides.count {
      let v = girdMembers[index]
      v.backgroundColor = UIColor.random()
      view.addSubview(v)
      let g = girdGuides[index]
      v.snp.makeConstraints { (make) in
        make.edges.equalTo(g).inset(5)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupLayoutGuide()
    setupGirdViews()
    view.setNeedsUpdateConstraints()
    
    let tap = UILongPressGestureRecognizer(target: self, action: #selector(longAction))
    view.addGestureRecognizer(tap)
  }
  
  @objc func longAction(_ tap: UILongPressGestureRecognizer) {
    switch tap.state {
    case .began:
      let tapPoint = tap.location(in: tap.view)
      print(tapPoint)
      
      for view in girdMembers {
        if view.frame.contains(tapPoint) {
          let index = girdMembers.firstIndex(of: view)
          print("index = \(index), view = \(view.frame)")
          return
        }
      }
    default:
      print("tap...\(tap.state)")
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
