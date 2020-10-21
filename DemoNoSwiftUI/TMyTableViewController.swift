//
//  TMyTableViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/10/21.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
// 仅仅用来布局
import SnapKit

class MyCell: UITableViewCell {
}
struct MyItem {
  let title: String
  let detail: String
  let avater: String
}
// tableview
class TMyTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
  let identifer = "myCell"
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifer)
    if cell == nil {
      fatalError("should register myCell")
    }
    if let cell = cell {
      let item = items[indexPath.row]
      cell.textLabel?.text = item.title
      cell.detailTextLabel?.text = item.detail
      cell.imageView?.image = UIImage(named: item.avater)
    }
    return cell!
  }
  

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  let myqueue: DispatchQueue = DispatchQueue(label: "mytableview.queue")

  lazy var items: [MyItem] = {
    let myItems = buildItems()
    return myItems
  }()
  
  var semphore = DispatchSemaphore(value: 0)
  
  func buildItems() -> [MyItem] {
    var list = [MyItem]()
    for i in 0 ..< 10 {
      let title = "title" + "\(i)"
      let detail = "detail" + "\(i)"
      let avater = "avater" + "\(i)"
      let item = MyItem(title: title, detail: detail, avater: avater)
      list.append(item)
    }
    return list
  }
  
  lazy var myTableView: UITableView = {
    let tv = UITableView()
    tv.register(MyCell.self, forCellReuseIdentifier: identifer)
    tv.delegate = self
    tv.dataSource = self
    return tv
  }()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var insertBtn: UIButton = {
    let btn = UIButton()
    btn.setTitle("insert", for: .normal)
    btn.backgroundColor = .random()
    btn.addTarget(self, action: #selector(insertData), for: .touchUpInside)

    return btn
  }()
  
  @objc func insertData(btn: UIButton) {
    print("insert....")
    // 插入A
    let itemA0 = MyItem(title: "insert A0", detail: "insert detail A0", avater: "")
    let itemA1 = MyItem(title: "insert A1", detail: "insert detail A1", avater: "")
    let itemA2 = MyItem(title: "insert A2", detail: "insert detail A2", avater: "")
    // 在第3个位置插入
    self.items.insert(contentsOf: [itemA0, itemA1, itemA2], at: 2)
    
    DispatchQueue.main.async {
      let indexPaths = [IndexPath(row: 2, section: 0),
                        IndexPath(row: 3, section: 0),
                        IndexPath(row: 4, section: 0)]
      self.myTableView.insertRows(at: indexPaths, with: .automatic)
    }
  }
  
  lazy var deleteBtn: UIButton = {
    let btn = UIButton()
    btn.setTitle("delete", for: .normal)
    btn.backgroundColor = .random()
    btn.addTarget(self, action: #selector(deleteData), for: .touchUpInside)

    return btn
  }()
  
  @objc func deleteData(btn: UIButton) {
    print("delete....")
    // 删除4
    self.items.remove(at: 3)
    DispatchQueue.main.async {
      let indexPaths = [IndexPath(row: 3, section: 0)]
      self.myTableView.deleteRows(at: indexPaths, with: .automatic)
    }
  }
  
  
  lazy var moveBtn: UIButton = {
    let btn = UIButton()
    btn.setTitle("move", for: .normal)
    btn.backgroundColor = .random()
    btn.addTarget(self, action: #selector(moveData), for: .touchUpInside)
    return btn
  }()
  
  @objc func moveData(btn: UIButton) {
    print("move....")
    // 移动
    self.items.swapAt(1, 2)
    self.items.swapAt(2, 3)
    
    DispatchQueue.main.async {
      self.myTableView.moveRow(at: IndexPath(row: 1, section: 0), to: IndexPath(row: 2, section: 0))
      self.myTableView.moveRow(at: IndexPath(row: 2, section: 0), to: IndexPath(row: 3, section: 0))
    }
  }
  
  lazy var time3Btn: UIButton = {
    let btn = UIButton()
    btn.setTitle("time3Btn", for: .normal)
    btn.backgroundColor = .random()
    btn.addTarget(self, action: #selector(time3), for: .touchUpInside)
    return btn
  }()
  
  @objc func time3(btn: UIButton) {
    print("time3Btn....")
    // 移动
    for i in 0 ... 2 {
      print("i = \(i)")
      updateSource()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.random()
    
    view.addSubview(myTableView)
    myTableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    
    view.addSubview(insertBtn)
    insertBtn.snp.makeConstraints { (make) in
      make.size.equalTo(50)
      make.center.equalToSuperview()
    }
    view.addSubview(deleteBtn)
    deleteBtn.snp.makeConstraints { (make) in
      make.size.equalTo(50)
      make.top.equalTo(insertBtn.snp.bottom)
      make.centerX.equalToSuperview()
    }
    view.addSubview(moveBtn)
    moveBtn.snp.makeConstraints { (make) in
      make.size.equalTo(50)
      make.top.equalTo(deleteBtn.snp.bottom)
      make.centerX.equalToSuperview()
    }
    
    view.addSubview(time3Btn)
    time3Btn.snp.makeConstraints { (make) in
      make.size.equalTo(50)
      make.top.equalTo(moveBtn.snp.bottom)
      make.centerX.equalToSuperview()
    }
  }

  func updateSource() {
    myqueue.async {
      // 插入A
      let itemA0 = MyItem(title: "insert A0", detail: "insert detail A0", avater: "")
      let itemA1 = MyItem(title: "insert A1", detail: "insert detail A1", avater: "")
      let itemA2 = MyItem(title: "insert A2", detail: "insert detail A2", avater: "")
      // 在第3个位置插入
      self.items.insert(contentsOf: [itemA0, itemA1, itemA2], at: 2)
      
      DispatchQueue.main.async {
        self.myTableView.performBatchUpdates({
          let indexPaths = [IndexPath(row: 2, section: 0),
                  IndexPath(row: 3, section: 0),
                  IndexPath(row: 4, section: 0)]
                  self.myTableView.insertRows(at: indexPaths, with: .none)
                  self.myTableView.endUpdates()
        }) { (finished) in
          self.semphore.signal()
        }
      }
      self.semphore.wait()
      
      self.items.remove(at: 3)

      DispatchQueue.main.async {
        self.myTableView.performBatchUpdates({
          let indexPaths = [IndexPath(row: 3, section: 0)]
          self.myTableView.deleteRows(at: indexPaths, with: .none)
        }) { (finished) in
          self.semphore.signal()
        }
      }
      self.semphore.wait()
      // 移动
      
      self.items.swapAt(1, 2)
      self.items.swapAt(2, 3)
      
      DispatchQueue.main.async {
        self.myTableView.performBatchUpdates({
          self.myTableView.moveRow(at: IndexPath(row: 1, section: 0), to: IndexPath(row: 2, section: 0))
          self.myTableView.moveRow(at: IndexPath(row: 2, section: 0), to: IndexPath(row: 3, section: 0))
          self.myTableView.endUpdates()
        }) { (finished) in
          self.semphore.signal()
        }
      }
      self.semphore.wait()
    }
  }
  
  deinit {
  }
  
}
