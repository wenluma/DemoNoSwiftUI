//
//  PresentViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/10/16.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class PresentViewController : UIViewController {
  
  let disposeBag = DisposeBag()
  
  var timer: Observable<Int> = Observable<Int>.timer(.seconds(1), period: .seconds(3), scheduler: MainScheduler.instance)
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var showButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("show", for: .normal)
    btn.backgroundColor = .random()
    btn.rx.tap.asDriver().drive(onNext: { [weak self] (_) in
      guard let self = self else { return }

      let pa = PresentViewControllerA(nibName: nil, bundle: nil)
      self.present(pa, animated: true) {
        print("show pa")
      }

      }).disposed(by: disposeBag)
    return btn
  }()
  
  lazy var dismissButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("dismiss", for: .normal)
    btn.backgroundColor = .random()
    btn.rx.tap.asDriver().drive(onNext: { (_) in
      
      }).disposed(by: disposeBag)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.random()
    
    view.addSubview(showButton)
    showButton.snp.makeConstraints { (make) in
      make.size.equalTo(100)
      make.center.equalToSuperview()
    }
    
    view.addSubview(dismissButton)
    dismissButton.snp.makeConstraints { (make) in
      make.size.equalTo(showButton.snp.size)
      make.top.equalTo(showButton.snp.bottom)
    }
    
    timer.subscribe { [weak self] (event) in
      guard let self = self, let _ = event.element else { return }
      print("check: \(self.topPresentedViewConntroller)")
    }.disposed(by: disposeBag)
  }
  
  deinit {
  }
  
}

class PresentViewControllerA : UIViewController {
  
  let disposeBag = DisposeBag()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var showButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("show", for: .normal)
    btn.backgroundColor = .random()
    btn.rx.tap.asDriver().drive(onNext: { [weak self] (_) in
      guard let self = self else { return }

      let pa = PresentViewControllerB(nibName: nil, bundle: nil)
      self.present(pa, animated: true) {
        print("show pb")
      }

      }).disposed(by: disposeBag)
    return btn
  }()
  
  lazy var dismissButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("dismiss", for: .normal)
    btn.backgroundColor = .random()
    btn.rx.tap.asDriver().drive(onNext: { [weak self](_) in
      guard let self = self else { return }
      self.dismiss(animated: true, completion: nil)
      }).disposed(by: disposeBag)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.random()
    
    view.addSubview(showButton)
    showButton.snp.makeConstraints { (make) in
      make.size.equalTo(100)
      make.center.equalToSuperview()
    }
    
    view.addSubview(dismissButton)
    dismissButton.snp.makeConstraints { (make) in
      make.size.equalTo(showButton.snp.size)
      make.top.equalTo(showButton.snp.bottom)
    }
  }
  
}


class PresentViewControllerB : UIViewController {
  
  let disposeBag = DisposeBag()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var showButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("show", for: .normal)
    btn.backgroundColor = .random()
    btn.rx.tap.asDriver().drive(onNext: { [weak self] (_) in
      guard let self = self else { return }

      let pa = PresentViewControllerA(nibName: nil, bundle: nil)
      self.present(pa, animated: true) {
        print("show pa")
      }

      }).disposed(by: disposeBag)
    return btn
  }()
  
  lazy var dismissButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("dismiss", for: .normal)
    btn.backgroundColor = .random()
    btn.rx.tap.asDriver().drive(onNext: { [weak self] (_) in
      guard let self = self else { return }
      self.dismiss(animated: true, completion: nil)
    }).disposed(by: disposeBag)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.random()
    view.addSubview(showButton)
    showButton.snp.makeConstraints { (make) in
      make.size.equalTo(100)
      make.center.equalToSuperview()
    }
    
    view.addSubview(dismissButton)
    dismissButton.snp.makeConstraints { (make) in
      make.size.equalTo(showButton.snp.size)
      make.top.equalTo(showButton.snp.bottom)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let rootPresetingVC = self.rootPresentingViewController
    print("rootPresetingVC = \(rootPresetingVC)")
  }
  
}
