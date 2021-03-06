//
//  RootTableViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/5.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class RootTableViewController : UITableViewController {
  
  var items: [(String, UIViewController.Type)] = {
    return [("rx", RxObservableViewController.self),
            ("table", MyTableViewController.self),
            ("table test", TMyTableViewController.self),
            ("frame-transform", FrameTransformViewController.self),
            ("safe area", SafeAreaViewController.self),
            ("keyboard", InputViewController.self),
            ("keyboard2", InputViewController2.self),
            ("cell selected", TableViewController2.self),
            ("switchUI", SwitchUIViewController.self),
            ("layout", LayoutViewController.self),
            ("layout2 - 四宫格", LayoutViewController2.self),
            ("layout3 - list", LayoutViewController3.self),
            ("layout4 - 子 view 影响 super view", LayoutViewController4.self),
            ("layout5 - 自动高度 super view", LayoutViewContorller5.self),

            ("image edge", ImageViewController.self),
            ("rotate", RotateViewController.self),
            ("textview 单行", TextViewController.self),
            ("textview-tail-icon 折行", TextViewController2.self),
            ("no animation", WithoutAnimationViewContronller.self),
            ("no-result for search", NoResultViewController.self),
            ("resource load", LoadBundletViewController.self),
            ("CGAffineTransform", CGAffineTransformViewController.self),
            ("GestureView rx", GestureViewController.self),
            ("手势冲突 scrollview", CollectionViewGestureViewController.self),
            ("view 位置变换", ConvertFrameViewController.self),
            
            ("阴影", ShadowViewController.self),
            ("连续present vc", PresentViewController.self),

            ("normal", ViewController.self)
    ]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var rect = CGRect(x: 10, y: 10, width: 20, height: 20)
    print("rect = \(rect.scaleXY(by: 2))")
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    let (name, _) = items[indexPath.row]
    cell?.textLabel?.text = name
    return cell!
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let (_, VCType) = items[indexPath.row]
    let vc = VCType.init(nibName:nil , bundle: nil)
    LOG_DEBUG()
    navigationController?.pushViewController(vc, animated: true)
  }
}
