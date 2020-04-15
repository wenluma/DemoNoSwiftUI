//
//  MGLImageExtension.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/15.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func mirror(orientation: UIImage.Orientation) -> UIImage? {
        guard let cgImg = self.cgImage else {
            return nil
        }
        return UIImage(cgImage: cgImage!, scale: self.scale, orientation: orientation)
    }
}
