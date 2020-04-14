//
//  ViewControllerDemo.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/14.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import Foundation
import UIKit

func alertVC(title: String?, message: String?) -> UIAlertController {
    let alertVC = UIAlertController.init(
        title: title,
        message: message,
        preferredStyle: .alert
    )

    let cancleAtion = UIAlertAction.init(
        title: "Cancel",
        style: .cancel
    ) { (action) in
    }
    
    alertVC.addAction(cancleAtion)
    
    return alertVC
}
