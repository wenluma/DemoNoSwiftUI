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
import SnapKit

class GradientView: UIView {
  
  struct GradientConfig {
    let colors: [UIColor]
    let locations: [NSNumber]
    let startPoint: CGPoint
    let endPoint: CGPoint
    
    init(colors: [UIColor], locations: [NSNumber]) {
      self.colors = colors
      self.locations = locations
      self.startPoint = CGPoint(x: 0, y: 0)
      self.endPoint = CGPoint(x: 0, y: 1.0)
    }
  }
  
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
  required init(frame: CGRect, config: GradientConfig) {
    super.init(frame: frame)
    update(config: config)
  }
  
  func update(config: GradientConfig) {
    let gradientLayer = self.layer as! CAGradientLayer
    gradientLayer.colors = config.colors.map({$0.cgColor})
    gradientLayer.locations = config.locations
    gradientLayer.startPoint = config.startPoint
    gradientLayer.endPoint = config.endPoint
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class RxObservableViewController: UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 
  var disposeBag: DisposeBag? = DisposeBag()
  
  private lazy var textimageButton : UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("邀请参加会议", for: .normal)
    
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.setImage(UIImage(named: "arrow_meeting"), for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.backgroundColor = . yellow
    button.semanticContentAttribute = .forceRightToLeft
    
    return button
  }()
  
  private lazy var gradientView: GradientView = {
    //定义渐变的颜色（从黄色渐变到橙色）
    let topColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.64)
    let middelColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
    let buttomColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
    let colors = [topColor, middelColor ,buttomColor]
    
    let locs: [NSNumber] = [0, 0.42, 1.0]
    
    let config = GradientView.GradientConfig(colors: colors, locations: locs)
    let gradient = GradientView(frame: .zero, config: config)
    return gradient
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(textimageButton)
    view.addSubview(gradientView)
    
    view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    
    textimageButton.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
    
    gradientView.snp.remakeConstraints { (make) in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.height.equalTo(120)
      make.leading.trailing.equalToSuperview()
    }
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
