//
//  ChangeColorLabel.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/18.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ChangeColorLabel: UIView {

    var font: UIFont?
    var textColor: UIColor?
    var changedColor: UIColor?
    //文本
    var text = ""
    
    lazy private var showLabel = UILabel(frame: CGRect.zero)
    lazy private var alphaLabel = UILabel(frame: CGRect.zero)
    //渐变效果的view
    lazy private var alphaView: AlphaView = AlphaView(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLabels() {
        
        self.addSubview(showLabel)
        self.addSubview(alphaLabel)
        
        // 设定alphaView
        alphaView.alphaTypeTwo()
        alphaLabel.mask = self.alphaView
        
    }
    
    
    //设定文本后将会重新更新控件
    func updateLabelView() {
        // 字体
        let font = self.font == nil ? showLabel.font : self.font
        
        // 设置文本 + 设置颜色 + 设置字体
        showLabel.text  = self.text;
        alphaLabel.text = self.text;
        showLabel.textColor  = self.textColor;
        alphaLabel.textColor = self.changedColor;
        showLabel.font  = font;
        alphaLabel.font = font;
        
        // 重置文本位置
        showLabel.sizeToFit()
        alphaLabel.sizeToFit()
        
        // 重新设置alphaView的frame值
        alphaView.frame.size.width  = showLabel.frame.size.width
        alphaView.frame.size.height = showLabel.frame.size.height
    }
    
    //颜色百分比
    func colorPercent(percent: CGFloat) {
        if (percent <= 0) {
            
            self.alphaView.frame.origin.x = -self.showLabel.frame.size.width
            
        } else {
            
            self.alphaView.frame.origin.x = -self.showLabel.frame.size.width + percent * self.showLabel.frame.size.width
        }
    }

}
