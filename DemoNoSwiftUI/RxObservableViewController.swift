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
 
  var disposeBag: DisposeBag? = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  func testCreate() {
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
         DispatchQueue.global().asyncAfter(deadline: .now() + .microseconds(1000)) {
           LOG_DEBUG()
           observer.onNext(1)
           observer.onCompleted()
         }
         return Disposables.create()
       }

       let disposable = observable.subscribe(onNext: { (value) in
         LOG_DEBUG("\(value)")
       }, onCompleted: {
         LOG_DEBUG()
       }) {
         LOG_DEBUG("end")
       }
       disposable.dispose()
       
       observable.subscribe()
  }
}
