//
//  RxObservableViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/6/5.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class RxObservableViewController: UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 
  
  override func viewDidLoad() {
    
    
    /// 同步执行
    let syncObservable = Observable<Int>.create { (observer) -> Disposable in
        LOG_DEBUG()
        observer.onNext(1)
        observer.onCompleted()
      return Disposables.create()
    }
    syncObservable.subscribe()
    
    
    /// async 执行
    let observable = Observable<Int>.create { (observer) -> Disposable in
      DispatchQueue.global().async {
        LOG_DEBUG()
        observer.onNext(1)
        observer.onCompleted()
      }
      return Disposables.create()
    }
    
    observable.subscribe(onNext: { (value) in
      LOG_DEBUG()
    }, onCompleted: {
      LOG_DEBUG()
    }) {
      LOG_DEBUG("end")
    }

    observable.subscribe()
  }
  
}
