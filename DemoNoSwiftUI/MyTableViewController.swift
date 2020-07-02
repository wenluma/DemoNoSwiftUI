//
//  MyTableViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/8.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
  
  private lazy var checkButton: UIButton = {
    let button = UIButton(type: .custom)
    return button
  }()
  
  private lazy var avatarImageView: UIImageView = {
    let imgV = UIImageView()
    imgV.layer.cornerRadius = 20
    imgV.layer.masksToBounds = true
    imgV.backgroundColor = .purple
    return imgV
  }()
  
  private lazy var nameLabel: UILabel = {
    let name = UILabel()
    return name
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(checkButton)
    addSubview(avatarImageView)
    addSubview(nameLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func willMove(toSuperview newSuperview: UIView?) {
    superview?.willMove(toSuperview: newSuperview)
    self.setNeedsUpdateConstraints()
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    checkButton.snp.remakeConstraints { (make) in
      make.centerY.equalToSuperview()
      make.width.height.equalTo(24+8+8)
      make.leading.equalTo(24-8)
    }
    
    avatarImageView.snp.remakeConstraints { (make) in
      make.width.height.equalTo(40)
      make.centerY.equalToSuperview()
      make.leading.equalTo(checkButton.snp.trailing).offset(10) // 18 -8
    }
    
    nameLabel.snp.remakeConstraints { (make) in
      make.centerY.equalToSuperview()
      make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
      make.trailing.lessThanOrEqualToSuperview().offset(-12)
    }
  }
  
  func update(title: String) {
    nameLabel.text = title
  }
}

class MyTableViewController: UIViewController,
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate {
  
  private lazy var mytableView: UITableView = {
    let tableView1 = UITableView(frame: .zero, style: .plain)
    tableView1.delegate = self
    tableView1.dataSource = self
    //    tableView1.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
    tableView1.register(ContactCell.self, forCellReuseIdentifier: "contactCellId")
    tableView1.allowsMultipleSelection = true
    tableView1.rowHeight = 56
    tableView1.sectionHeaderHeight = 25

    return tableView1
  }()
  
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.placeholder = "搜索"
    searchBar.showsCancelButton = false
    return searchBar
  }()

//  var names = ["张三", "李四", "王五", "王朝", "阿拉斯加", "哈士奇", "马汉", "张龙", "赵虎",  "长江", "长江1号", "&*>?", "弯弯月亮", "that is it ?", "山水之间", "倩女幽魂", "疆土无边"]
//  var searchlist = [String]()
//  var allDataSource = NSDictionary()
//  var indexDataSource = [Any]()

//  var isSearch : Bool = false
  
  private lazy var dataSource: [String: Array<String>] = {
    var allDataSource = [String: Array<String>]()
    allDataSource["A"] = ["a", "a1", "啊哦啊哦啊哦啊哦啊哦啊哦啊哦啊哦啊哦啊哦啊哦","a", "a1", "啊哦","a", "a1", "啊哦","a", "a1", "啊哦","a", "a1", "啊哦","a", "a1", "啊哦","a", "a1", "啊哦","a", "a1", "啊哦"]
    allDataSource["B"] = ["b", "b2", "辈子","b2", "辈子","b2", "辈子","b2", "辈子","b2", "辈子"]
    allDataSource["C"] = ["c", "c2", "畅月","c2", "畅月","c2", "畅月","c2", "畅月","c2", "畅月","c2", "畅月","c2", "畅月","c2", "畅月"]
    return allDataSource
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(mytableView)
    view.addSubview(searchBar)
    view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    searchBar.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    mytableView.snp.makeConstraints { (make) in
      make.top.equalTo(searchBar.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  func processData() {
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let keys = dataSource.keys.sorted()
    let key = keys[section]
    return dataSource[key]!.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "contactCellId") as! ContactCell
    let keys = dataSource.keys.sorted()
    let key = keys[indexPath.section]
    let value = dataSource[key]![indexPath.row]
    cell.update(title: value)
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let keys = dataSource.keys.sorted()
    return keys[section]
  }
  
  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    let keys = dataSource.keys.sorted()
    return keys
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .none
  }
  
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    
  }
}
