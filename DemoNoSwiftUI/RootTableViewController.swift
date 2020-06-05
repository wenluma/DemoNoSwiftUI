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
            ("normal", ViewController.self)]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
