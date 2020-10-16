//
//  MGLViewControllerEx.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/10/16.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit

extension UIViewController {
  // 找到最上层的 present 出来的 vc
  var topPresentedViewConntroller: UIViewController {
    var current = self
    while let next = current.presentedViewController {
      current = next
    }
    return current
  }
  
  // 找到最下层的 支撑 present 的 vc
  var rootPresentingViewController: UIViewController {
    var current = self
    while let next = current.presentingViewController {
      current = next
    }
    return current
  }
}
