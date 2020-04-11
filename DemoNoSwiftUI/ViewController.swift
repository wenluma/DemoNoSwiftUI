//
//  ViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/10.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var addView : UIButton?
    var btn : UIButton?
    var isOpen : Bool = false
    
    var btn2 : UIButton?
    var isOpen2 : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let view = UIButton()
         self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.leading.equalTo(100)
            make.top.equalTo(100)
            make.width.height.equalTo(50)
        }
        view.backgroundColor = UIColor.yellow
        
        view.addTarget(self, action: #selector(didTap2), for: .touchUpInside)
        self.addView = view
        self.addView!.backgroundColor = UIColor.yellow
    }
    
    /// frame 的修改 右上 -》 左下
    @objc func didTap2() {

        if (isOpen == false) {
            isOpen = true
            self.btn = UIButton()
            self.btn?.backgroundColor = UIColor.brown
            self.view.addSubview(self.btn!)
            self.btn?.frame =  CGRect(x:235.333 ,y:82, width:168.667, height:  140)
            let view = self.btn!
            view.layer.frame = CGRect(x:self.btn!.frame.maxX ,y: self.btn!.frame.minY, width:0, height: 0)

            UIView.animate(withDuration: 0.3, animations: {
                view.frame = CGRect(x:235.333 ,y:82, width:168.667, height:  140)
            }) { (finished) in
            }
            
        } else {
            isOpen = false

            self.btn?.frame =  CGRect(x:235.333 ,y:82, width:168.667, height:  140)
            let view = self.btn!
            let targetFrame = CGRect(x:self.btn!.frame.maxX ,y: self.btn!.frame.minY, width:0, height: 0)

            UIView.animate(withDuration: 0.3, animations: {
                view.frame = targetFrame
            }) { (finished) in
            }
        }
        
        didTap3()
        
    }
    
    // 缩放动画 右上角 -》 左下角
    func didTap3() {
        let y: Double = 82 + 140 + 80
        if (isOpen2 == false) {
            isOpen2 = true
            self.btn2?.removeFromSuperview()
            
            self.btn2 = UIButton()
            self.btn2?.backgroundColor = UIColor.brown
            self.view.addSubview(self.btn2!)
            let frame =  CGRect(x:235.333 ,y:y, width:168.667, height:  140)
            self.btn2?.frame =  frame
            let view = self.btn2!
            view.layer.anchorPoint = CGPoint(x: 1, y: 0)
            view.frame = frame
            
            view.layer.setAffineTransform(CGAffineTransform.init(scaleX: 0.001, y: 0.001))

            UIView.animate(withDuration: 0.3, animations: {
                view.layer.setAffineTransform(CGAffineTransform.init(scaleX: 1, y: 1))
            }) { (finished) in
            }
            
        } else {
            isOpen2 = false

            let view = self.btn2!
            view.layer.setAffineTransform(CGAffineTransform.init(scaleX: 1, y: 1))

            UIView.animate(withDuration: 0.3, animations: {
                view.layer.setAffineTransform(CGAffineTransform.init(scaleX: 0.001, y: 0.001))// 不能写0， 0时，没有动画效果了，应该是个系统bug
            }) { (finished) in
            }
        }
    }
    
    @objc func didTapChatButton() {
        
        self.btn?.snp.removeConstraints()
        self.btn?.removeFromSuperview()
        
        self.btn = UIButton()
        self.btn?.backgroundColor = UIColor.brown
        self.view.addSubview(self.btn!)
        let btn = self.btn!
        
        btn.snp.makeConstraints { (maker) in
            maker.top.equalTo(addView!.snp.bottom).offset(5)
            maker.trailing.equalTo(addView!.snp.trailing).offset(5)
            maker.width.height.equalTo(0);
        }
        self.view.layoutIfNeeded()


        
//        btn.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
//        btn.layer.position = CGPoint(x:150, y: 100)
//        btn.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {
//            btn.transform = CGAffineTransform.identity
            btn.snp.updateConstraints { (maker) in
                maker.top.equalTo(self.addView!.snp.bottom).offset(5)
                maker.trailing.equalTo(self.addView!.snp.trailing).offset(5)
                maker.width.height.equalTo(100);
            }
            self.view.layoutIfNeeded()
        }

        
    }

}


