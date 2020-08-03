//
//  GestureViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/30.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GestureViewController : UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let tap = UITapGestureRecognizer()
    view.addGestureRecognizer(tap)
    tap.rx.event
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
      .subscribe(onNext: { (tap) in
        print("\(tap)")
      })
      .disposed(by: disposeBag)
  }
  
  
}
