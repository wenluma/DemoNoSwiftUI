//
//  UICollectionView.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/5/25.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
  func mgl_isVisiable(indexPath: IndexPath) -> Bool {
    guard let superView = self.superview ,let layoutAttribute = self.layoutAttributesForItem(at: indexPath) else {
      return false
    }
    
    let pointInSuper = self.convert(layoutAttribute.center, to: superView)
    return superView.frame.contains(pointInSuper)
  }
  
  func currentIndexPath(of point: CGPoint) -> IndexPath? {
    let offsetX = point.x + self.center.x
    let offsetY = point.y + self.center.y
    return self.indexPathForItem(at: CGPoint(x: offsetX, y: offsetY))
  }
}
