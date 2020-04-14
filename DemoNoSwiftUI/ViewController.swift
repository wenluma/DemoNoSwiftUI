//
//  ViewController.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/10.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SnapKit
import YYText

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
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            
        }) { (finished) in
            
        }
        
        richText()
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
    
    func richText() -> Void {
        //        NSAttributedString.Key.foregroundColor.rawValue
        
        //        {
        //            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
        //            one.yy_font = [UIFont boldSystemFontOfSize:30];
        //            one.yy_color = [UIColor redColor];
        //
        //            YYTextBorder *border = [YYTextBorder new];
        //            border.cornerRadius = 50;
        //            border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
        //            border.strokeWidth = 0.5;
        //            border.strokeColor = one.yy_color;
        //            border.lineStyle = YYTextLineStyleSingle;
        //            one.yy_textBackgroundBorder = border;
        //
        //            YYTextBorder *highlightBorder = border.copy;
        //            highlightBorder.strokeWidth = 0;
        //            highlightBorder.strokeColor = one.yy_color;
        //            highlightBorder.fillColor = one.yy_color;
        //
        //            YYTextHighlight *highlight = [YYTextHighlight new];
        //            [highlight setColor:[UIColor blueColor]];
        //            [highlight setBackgroundBorder:highlightBorder];
        //            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //                [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        //            };
        //            [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
        //
        //            [text appendAttributedString:one];
        //            [text appendAttributedString:[self padding]];
        //        }
        let str = "Another Link"
        let range = NSMakeRange(0, str.count)
        let mutAttributed = NSMutableAttributedString(string: str)
        mutAttributed.yy_font = .boldSystemFont(ofSize: 30)
        mutAttributed.yy_color = .blue
        
        let highlight = YYTextHighlight()
        highlight.setColor(.red)
        //        highlight.tapAction = { [weak self] (view, attributeStr, range, rect) in
        ////                   guard let self = self else { return }
        //            print("tap: ...")
        //        }
        mutAttributed.yy_setTextHighlight(highlight, range: range)
        
        let label = YYLabel()
        self.view.addSubview(label)
        label.attributedText = mutAttributed
        label .sizeToFit()
        label.center = CGPoint(x: 100, y:300)
        label.highlightTapAction = { [weak self] (view, attributeStr, range, rect) in
            guard let `self` = self else { return }
            print("tap: ...")
        }
    }
}

// 加锁， 解锁操作
let lock = NSLock()
func operationLock() {
    lock.lock(); defer { lock.unlock() }
    print("hello lock")
    
    autoreleasepool {
        print("hello auto releasepool")
    }
}

//// tabbar 修改 底部的毛玻璃效果， shadow color的颜色修改, 结合底部的 scollview 才能看出效果，注意 clipsToBounds
//func blurEffect() {
//    let bottomSafeAreaHeight: CGFloat =
//    UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
//    let frame = CGRect.init(0, 0, UIScreen.main.bounds.size.width, 49 + bottomSafeAreaHeight)
//    let backView: UIImageView = UIImageView(frame: frame)
//    backView.image = UIImage(color: UIColor.white.withAlphaComponent(0.5), size: frame.size)
//
//    let effect = UIBlurEffect.init(style: .light)
//    let effectView: UIVisualEffectView  = UIVisualEffectView(effect: effect)
//    effectView.frame = backView.bounds
//    backView.addSubview(effectView)
//
//    self.tabBar.insertSubview(backView, at: 0)
//    tabBar.backgroundImage = backView.image
//    tabBar.shadowImage = UIImage(color: .kimGray04, size: CGSize(width:width, height: 0.4))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) // tabbar 顶部的 shadow color 修改， 防止被拉伸

//}

//let hightlight = YYTextHighlight()
//hightlight.tapAction = { (view, attStr, range, tect) in
//    self.delegate?.messageLabel(onPressShowAllContent: self)
//}
//moreAttr.yy_setTextHighlight(hightlight, range: NSMakeRange(0, moreAttr.length))

// 类型判断
//guard let attributes = layoutAttributes as? MessagesCollectionViewLayoutAttributes else { return }
