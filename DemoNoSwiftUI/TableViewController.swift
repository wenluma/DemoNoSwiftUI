//
//  TableViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/9.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class Cell1: UITableViewCell {
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    if highlighted {
      self.contentView.backgroundColor = .red
    } else {
      contentView.backgroundColor = .yellow
    }
  }
}

class TableViewController2 : UITableViewController {
  
  var items: [(String, UIViewController.Type)] = {
    return [("rx", RxObservableViewController.self),
            ("normal", ViewController.self),
            ("table", MyTableViewController.self),
            ("frame-transform", FrameTransformViewController.self),
            ("safe area", SafeAreaViewController.self),
            ("keyboard", InputViewController.self),
            ("keyboard2", InputViewController2.self)
    ]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var rect = CGRect(x: 10, y: 10, width: 20, height: 20)
    print("rect = \(rect.scaleXY(by: 2))")
    
    tableView.register(Cell1.self, forCellReuseIdentifier: "cell")
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
//    navigationController?.pushViewController(vc, animated: true)
  }
}
