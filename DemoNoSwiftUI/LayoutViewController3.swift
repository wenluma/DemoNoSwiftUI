//
//  LayoutViewController3.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/2.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//
import UIKit
import SnapKit

class LayoutViewController3: UIViewController {
  
  let edgeGuide = UILayoutGuide()
  var girdGuides = [UILayoutGuide]()
  var girdMembers = [UIView].repeated(initCount: 4) { () -> UIView in
    UIView()
  }
  
  var usingCount = 2
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
         
    for _ in 0..<2 {
      girdGuides.append(UILayoutGuide())
    }
    
    for _ in 0..<4 {
      girdMembers.append(UIView())
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupLayoutGuide() {
    view.addLayoutGuide(edgeGuide)
    edgeGuide.snp.remakeConstraints { (make) in
      make.leading.equalTo(10)
      make.trailing.equalTo(-10)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    
    girdGuides.forEach({ view.addLayoutGuide($0) })
    
    setupChildLayoutGuides()
  }
  
  func setupChildLayoutGuides() {
    let g0 = girdGuides[0]
    let g1 = girdGuides[1]
        
    let mut: Double = Double(4-usingCount)/Double(8)
    print("mut = \(mut)")
    g0.snp.remakeConstraints { (make) in
      make.trailing.equalTo(edgeGuide.snp.trailing)
      make.leading.equalTo(edgeGuide.snp.leading)
      make.top.equalTo(edgeGuide.snp.top)
      make.height.equalTo(edgeGuide.snp.height).multipliedBy(mut)
    }
    
    g1.snp.remakeConstraints { (make) in
      make.leading.equalTo(edgeGuide.snp.leading)
      make.trailing.equalTo(edgeGuide.snp.trailing)
      make.bottom.equalTo(edgeGuide.snp.bottom)
      make.height.equalTo(g0)
    }
  }
  
  func setupGirdViews() {
    girdMembers.forEach({ $0.removeFromSuperview() })

    let g0 = girdGuides[0]
    var lastTop = g0.snp.bottom
    for index in 0 ..< usingCount {
      let v = girdMembers[index]
      v.backgroundColor = UIColor.random()
      view.addSubview(v)

      v.snp.makeConstraints { (make) in
        make.leading.trailing.equalTo(edgeGuide)
        make.top.equalTo(lastTop)
        make.height.equalTo(edgeGuide.snp.height).dividedBy(4)
      }
      lastTop = v.snp.bottom
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupLayoutGuide()
    setupGirdViews()
    view.setNeedsUpdateConstraints()
    
    let tap = UITapGestureRecognizer.init(target: self, action: #selector(updateViews))
    view.addGestureRecognizer(tap)
  }
  
  @objc
  func updateViews(_ tap: UITapGestureRecognizer) {
    usingCount = (usingCount+1)
    if usingCount > 4 {
      usingCount = 1
    }
    print("usingCount = \(usingCount)")
    setupChildLayoutGuides()
    setupGirdViews()
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
