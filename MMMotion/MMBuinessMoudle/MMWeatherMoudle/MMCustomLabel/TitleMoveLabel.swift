//
//  TitleMoveLabel.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class TitleMoveLabel: UIView {
    
    private lazy var label: UILabel = {
        var label = UILabel.init(frame: CGRect.zero)
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    private var startRect: CGRect = CGRect.zero
    private var midRect: CGRect = CGRect.zero
    private var endRect: CGRect = CGRect.zero

    private var font: UIFont?
    private var text: String?
    private var textColor: UIColor?
    

    
    //移动距离
    private var moveGap: CGFloat = 0
    
    class func withText(text: String) -> TitleMoveLabel {
                
        let titleMove = TitleMoveLabel(frame: CGRect(x: 20, y: 10, width: 0, height: 0))
        titleMove.text = text
        titleMove.textColor = UIColor.black
       
        //根据设备不同的尺寸设置字体大小
//        if deviceModelWidth == 414.0 && deviceModelHeight == 736.0 {
//            titleMove.font = UIFont(name: LATO_LIGHT, size: 30)
//        }else if deviceModelWidth == 375.0 && deviceModelHeight == 667.0 {
//            titleMove.font = UIFont(name: LATO_LIGHT, size: 20)
//        }else {
//            titleMove.font = UIFont(name: LATO_BOLD, size: 20)
//        }
        titleMove.font = UIFont(name: LATO_LIGHT, size: 20)

        
        titleMove.moveGap = 10.0
        titleMove.buildView()
        
        return titleMove
    }
    
    //创建View
    func buildView() {
        
        self.backgroundColor = UIColor.clear
        
        //添加label
        self.label.text = self.text
        self.addSubview(self.label)
        
        //设置文本颜色
        if (self.textColor != nil) {
            self.label.textColor = self.textColor
        }
        
        //设置字体
        if (self.font != nil) {
            self.label.font = self.font
        }
        
        //重设置Frame值
        self.label.sizeToFit()
        
        //重设置当前View的Frame值
        self.frame.size.width = label.frame.size.width
        self.frame.size.height = label.frame.size.height
        
        //存储frame值
        self.label.frame.origin.x -= self.moveGap
        self.startRect = self.label.frame
        
        self.label.frame.origin.x += self.moveGap
        self.midRect = self.label.frame
        
        self.label.frame.origin.x += self.moveGap
        self.endRect = self.label.frame
        
        //复位frame值
        self.label.frame = self.startRect
        self.label.alpha = 0.0
        
    }
    
    func show() {
        
        UIView.animate(withDuration: 1.75) { 
            
            self.label.frame = self.midRect
            self.label.alpha = 1.0
            
        }
        
    }
    
    func hide() {
        
        UIView.animate(withDuration: 0.75, animations: { 
            
            self.label.frame = self.endRect
            self.label.alpha = 0.0
            
        }) { (_) in
            self.label.frame = self.startRect
        }
    }

    
}





































