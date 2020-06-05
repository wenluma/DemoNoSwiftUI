//
//  RootTableViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/5.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class RootTableViewController : UITableViewController {
  
  var items: [String] = {
    return ["rx",
            "normal"]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    cell?.textLabel?.text = items[indexPath.row]
    return cell!
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
}
