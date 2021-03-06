//
//  CGAffineTransformViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/7/22.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CGAffineTransformViewController: UIViewController {
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var imageView: UIImageView = {
    let img = UIImage(named: "008")
    let imgV = UIImageView(image: img)
    imgV.contentMode = .scaleToFill
    return imgV
  }()
  
  private lazy var grayView: UIView = {
    let v = UIView()
    v.backgroundColor = .gray
    return v
  }()
  
  private lazy var textView: UITextView = {
    let tv = UITextView()
    return tv
  }()
  
  private lazy var safeBottomLayoutGuide: UILayoutGuide = {
    return UILayoutGuide()
  }()
  
  private var keyboardBottom: Constraint?
  private lazy var keyboardManager: KeyboardManager = {
    let manager = KeyboardManager()
    manager.publishDiff.takeUntil(self.rx.deallocated).bind { [weak self] (diff) in
      guard let self = self else { return }
      let height = max(diff, 0)
      self.keyboardBottom?.update(offset: height)
    }
    
    return manager
  }()
  
  @objc
  func hiddenKeyboard(tap: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  
  var originFrame: CGRect!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    view.addSubview(grayView)
    view.addSubview(imageView)
//    view.addSubview(textView)
    view.addLayoutGuide(safeBottomLayoutGuide)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
    view.addGestureRecognizer(tap)
    keyboardManager.view = view
    
    let rect = CGRect.zero.integral
    grayView.snp.makeConstraints { (make) in
      make.size.equalTo(100)
      make.centerX.equalToSuperview()
      make.top.equalTo(150)
    }
    
    imageView.frame = CGRect(origin: CGPoint(x: 0, y: 150), size: CGSize(width: 100, height: 100)).offsetBy(dx: UIScreen.main.bounds.width/2 - 50, dy: 0)
    originFrame = imageView.frame
    
//    imageView.snp.makeConstraints { (make) in
//      make.size.equalTo(grayView)
//      make.center.equalTo(grayView)
//    }
    
//    a,  b, 0
//    c,  d, 0
//    tx, ty, 1
//    angle 角度 pi / 180
    
    let stack = UIStackView()
    stack.axis = .vertical
    view.addSubview(stack)
    stack.backgroundColor = .lightGray
    
    repeat {
      let hStack = createStack()

      let inverted = createButton(title: "inverted 逆矩阵")
      inverted.rx.tap
        .asDriver()
        .drive(onNext: { [weak self] (_) in
          guard let self = self else { return }
          UIView.animate(withDuration: 0.3) {
            self.imageView.transform = self.imageView.transform.inverted()
          }
        })
        .disposed(by: disposeBag)
      hStack.addArrangedSubview(inverted)
      
      let reset = createButton(title: "clean reset")
      reset.rx.tap
      .asDriver()
      .drive(onNext: { [weak self] (_) in
        guard let self = self else { return }
        
        // 对 textfield 清空
        stack.arrangedSubviews.filter { (view) -> Bool in
          view.isKind(of: UIStackView.self)
        }.flatMap { (view) -> [UITextField] in
          if let stackView = view as? UIStackView {
            return stackView.arrangedSubviews.filter { (sub) -> Bool in
              sub.isKind(of: UITextField.self)
            }.map { (view) -> UITextField in
              return view as! UITextField
            }
          }
          return []
        }.forEach { (textField) in
          textField.text = nil
          // 要坚定数据的事件处理，则需要更新 events
          textField.sendActions(for: .allEvents)
        }

        // 清除转换， 可以改变输入框的内容
//        self.container.forEach { (item) in
//          item.asControlProperty().onNext("0")
//        }

//        UIView.animate(withDuration: 0.3) {
//          self.imageView.transform = CGAffineTransform.identity
//        }
      })
      .disposed(by: disposeBag)
      hStack.addArrangedSubview(reset)

      stack.addArrangedSubview(hStack)
    } while false
    
    repeat {
      let hStack = createStack()
      hStack.addArrangedSubview(createTextField(with: "sx = ?"))
      hStack.addArrangedSubview(createTextField(with: "b = ?"))
      hStack.addArrangedSubview(createTextField(with: "0 = ?"))
      stack.addArrangedSubview(hStack)
    } while false
    
    repeat {
      let hStack = createStack()
      hStack.addArrangedSubview(createTextField(with: "c = ?"))
      hStack.addArrangedSubview(createTextField(with: "sy = ?"))
      hStack.addArrangedSubview(createTextField(with: "0 = ?"))
      stack.addArrangedSubview(hStack)
    } while false
     
    repeat {
      let hStack = createStack()
      hStack.addArrangedSubview(createTextField(with: "tx = ?"))
      hStack.addArrangedSubview(createTextField(with: "ty = ?"))
      hStack.addArrangedSubview(createTextField(with: "1 = ?"))
      stack.addArrangedSubview(hStack)
    } while false
    
    repeat {
      let hStack = createStack()
      hStack.addArrangedSubview(createTextField(with: "range[0-360] * pi/180 "))
      stack.addArrangedSubview(hStack)
    } while false
    
    repeat {
      let hStack = createStack()
      hStack.addArrangedSubview(createPointTextField(with: "anchor.x = ? [0-1]"))
      hStack.addArrangedSubview(createPointTextField(with: "anchor.y = ? [0-1]"))
      view.addSubview(hStack)
      hStack.snp.makeConstraints { (make) in
        make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        make.leading.trailing.equalToSuperview()
      }
    } while false
    
    safeBottomLayoutGuide.snp.makeConstraints { (make) in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.trailing.equalToSuperview()
      self.keyboardBottom = make.height.equalTo(0).constraint
    }
    
    stack.snp.makeConstraints { (make) in
      make.bottom.equalTo(safeBottomLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }
    
    observerTextChanged()
  }
  
  func observerTextChanged() {
    // 仿射变换的设置
    if container.count == 10 {
      Observable.combineLatest(container)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] (infos) in
          guard let self = self else { return }
          let a = Float(infos[0]) ?? 1
          let b = Float(infos[1]) ?? 0
          let c = Float(infos[3]) ?? 0
          let d = Float(infos[4]) ?? 1
          let tx = Float(infos[6]) ?? 0
          let ty = Float(infos[7]) ?? 0

          var angle = Float(infos.last!) ?? 0

          var transform = CGAffineTransform(a: CGFloat(a),
                                            b: CGFloat(b),
                                            c: CGFloat(c),
                                            d: CGFloat(d),
                                            tx: CGFloat(tx),
                                            ty: CGFloat(ty))

          if angle != 0 {
            angle = Float(Double(angle) * Double.pi / 180)
            transform = transform.concatenating(CGAffineTransform(rotationAngle: CGFloat(angle)))
          }
          
          UIView.animate(withDuration: 0.25) {
            self.imageView.transform  = transform
          }
        })
        .disposed(by: disposeBag)
    }
    
    // 锚点的设置
    if anchorContainer.count == 2 {
      Observable.combineLatest(anchorContainer)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] (infos) in
          let x = Float(infos[0]) ?? 0.5
          let y = Float(infos[1]) ?? 0.5
          let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
          guard let self = self else { return }
          /*
           position.x = frame.origin.x + anchorPoint.x * bounds.size.width；
           position.y = frame.origin.y + anchorPoint.y * bounds.size.height；
           
           frame.origin.x = position.x - anchorPoint.x * bounds.size.width；
           frame.origin.y = position.y - anchorPoint.y * bounds.size.height；
           **/
//          let size = self.imageView.frame.size
//          let center = self.imageView.center
          
          self.imageView.layer.anchorPoint  = point
          self.imageView.frame = self.originFrame
          
//          self.imageView.applyTransform(withScale: 1, anchorPoint: point)
          
//          let frame = self.imageView.frame
//          var old = self.imageView.layer.position
//          self.imageView.layer.anchorPoint = CGPoint(x: CGFloat(x), y: CGFloat(y))
//          old.x += CGFloat(x) * frame.width
//          old.y += CGFloat(y) * frame.width
//          self.imageView.layer.position = old
        }).disposed(by: disposeBag)
    }
  }
  var disposeBag = DisposeBag()
  var container = [ControlProperty<String>]()
  
  func createTextField(with placeholder: String) -> UITextField {
    let textField = UITextField()
    textField.textAlignment = .center
    textField.placeholder = placeholder
    // 有风险, 数量过多
    container.append(textField.rx.text.orEmpty)
    
    return textField
  }
  
  var anchorContainer = [ControlProperty<String>]()
  
  func createPointTextField(with placeholder: String) -> UITextField {
    let textField = UITextField()
    textField.textAlignment = .center
    textField.placeholder = placeholder
    anchorContainer.append(textField.rx.text.orEmpty)
    return textField
  }
  func createStack(with axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
    let hStack = UIStackView()
    hStack.axis = axis
    hStack.distribution = .fillEqually
    return hStack
  }
  
  func createButton(title: String) -> UIButton {
    let btn = UIButton(type: .custom)
    btn.setTitle(title, for: .normal)
    btn.setTitleColor(.systemBlue, for: .normal)
    return btn
  }
}
