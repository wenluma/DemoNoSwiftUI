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
        
        view.addTarget(self, action: #selector(didTapChatButton), for: .touchUpInside)
        self.addView = view
        self.addView!.backgroundColor = UIColor.yellow
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            
        }) { (finished) in
            
        }
        
        richText()
        
        let img = UIImage(named: "voice_icon")
        let img2 = img?.mirror(orientation: .left)
        let imgv = UIImageView(image: img2)
        self.view.addSubview(imgv)
        imgv.sizeToFit()
        imgv.center = CGPoint(x: 50, y: 200);
        
        
//        bottom， right -x < 0 内偏移
//        make.bottom.equalTo(descriptionLabel.snp.bottom).offset(-8)

        
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

        let apple: Fruit = Apple(name: "apple")
        Fruit.intro()
        Fruit.drink = false
        print("fruit.drink = \(Fruit.drink)")
        Apple.drink = true
        print("Apple.drink = \(Apple.drink)")

        let makeAddress = (apple as! Apple).address
        print(makeAddress)
        print(apple.toRawPointer())
        
    }
    
    func rich0() {
        let str = "哈哈哦" // YYLabel 的高度设定， 跟 系统的计算，YYLabel 不同
        let label = getYYLabel(str: str, maxWidth: 150)
        view.addSubview(label)
        label.center = CGPoint(x:250, y:150);
    }
    
    func rich1() {
        let str = "abdsgewg@23"
        let label = getYYLabel(str: str, maxWidth: 150)
        view.addSubview(label)
        label.center = CGPoint(x:250, y:100);
    }
    
    func rich2() {
        let str = "abcd"
        let label = getYYLabel(str: str, maxWidth: 150)
        view.addSubview(label)
        label.center = CGPoint(x:250, y:200);
    }
    
    func rich3() {
        let str = "as9啊个"
        let label = getYYLabel(str: str, maxWidth: 150)
        view.addSubview(label)
        label.center = CGPoint(x:250, y:300);

    }
    
    func richemoji() {
        let label = getYYLableEmoji(emojiImgName: "emoji_almostcry", str: "", emojiSize: 13, fontSize: 16, maxWidth: 100)
        view.addSubview(label)
        label.center = CGPoint(x:100, y:100);
    }
    
    func richemoji2() {
        let label = getYYLableEmoji(emojiImgName: "emoji_almostcry", str: "呵呵啊哦", emojiSize: 16, fontSize: 16, maxWidth: 100)
        view.addSubview(label)
        label.center = CGPoint(x:100, y:150);
    }
    
    func setTextCentered(attributedText: NSMutableAttributedString?) {
        guard let text = attributedText else { return }
        if text.length == 0 {
            return
        }
//        if text.string.isChinese() {
//            if #available(iOS 11.0, *) {
//                text.addAttribute(.baselineOffset, value: -1.1, range: NSMakeRange(0, text.length))
//            } else {
//                text.addAttribute(.baselineOffset, value: -0.4, range: NSMakeRange(0, text.length))
//            }
//        }
    }
// 计算采用 yy_getAttrRect 获取一个准确的值
//
    
    func richText() -> Void {
        rich0()
        rich1()
        rich2()
        rich3()
        richemoji()
        richemoji2()
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
        
        
        let str = "奥三等"
        let range = NSMakeRange(0, str.count)
        let mutAttributed = NSMutableAttributedString(string: str)
        mutAttributed.yy_font = .boldSystemFont(ofSize: 14)
        mutAttributed.yy_lineSpacing = 6
        mutAttributed.yy_color = .blue
        
        let rect = mutAttributed .boundingRect(with: CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
//        print("Testi奥三等 \(rect)")
        
        
        
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
