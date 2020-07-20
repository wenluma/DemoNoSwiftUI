//
//  File.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/17.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

class LoadBundletViewController: UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
     super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    // 获取制定文件夹下的文件路径
    let path = Bundle.main.path(forResource: "KSModelLandmark01", ofType: "model", inDirectory: "ycnn_models")
    LOG_DEBUG("path = \(path)")
    
    // 获取特定的文件夹
    let p2 = Bundle.main.path(forAuxiliaryExecutable: "ycnn_models")?.appending("/")
    LOG_DEBUG("p2 = \(p2)")

    if let path = path {
      let isReadable = FileManager.default.isReadableFile(atPath: path)
      LOG_DEBUG("isReadable = \(isReadable)")
    }
  }
  
  
}
