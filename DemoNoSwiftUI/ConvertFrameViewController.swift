//
//  ConvertFrameViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/9/23.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class ConvertFrameViewController : UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let disposeBag = DisposeBag()
  
  lazy var smallView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  lazy var smImageView: UIImageView = {
    let imgV = UIImageView()
    imgV.image = UIImage(named: "008")
    return imgV
  }()
  
  lazy var bigImageView: UIImageView = {
    let imgV = UIImageView()
    imgV.image = UIImage(named: "009")
    return imgV
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let tap = UITapGestureRecognizer()
    smallView.addGestureRecognizer(tap)
    tap.rx.event
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
      .subscribe(onNext: { (tap) in
        print("\(tap)")
        
        let convertFrame = self.smImageView.convert(self.smImageView.frame, to: self.view)
        print("conver = \(convertFrame)")
        let bigFrame = self.bigImageView.frame
        print("big = \(bigFrame)")

        self.smImageView.frame = convertFrame
        self.view.addSubview(self.smImageView)

        UIView.animate(withDuration: 0.3, animations: {
          self.bigImageView.frame = convertFrame
          self.smImageView.frame = bigFrame
        }) { (finished) in
          let sm = self.smImageView
          let bm = self.bigImageView
          self.bigImageView = sm
          self.smImageView = bm
          self.smallView.addSubview(self.smImageView)
          self.smImageView.frame = self.smallView.bounds
        }
      })
      .disposed(by: disposeBag)
    
    view.addSubview(bigImageView)
    bigImageView.frame = self.view.frame
    smImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    view.addSubview(smallView)
    smallView.frame = CGRect(x: 275, y: 100, width: 100, height: 140)
    
    smallView.addSubview(smImageView)
    smImageView.frame = smallView.bounds
    smImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  
}
