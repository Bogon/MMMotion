//
//  WindSpeedView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class WindSpeedView: UIView {
    
    //一秒钟转几圈
    var circleByOneSecond: CGFloat = 0
    
    //风的速度
    var windSpeed: CGFloat = 0 {
        didSet{
            circleByOneSecond = windSpeed / 5
        }
    }
    
    private var threeLineView: ThreeLineView!
    lazy private var line = UIView()
    private var lineStoreValue: CGRectStoreValue = CGRectStoreValue()
    
    lazy private var circleView = UIView()
    
    lazy private var titleMoveLabel: TitleMoveLabel = TitleMoveLabel.withText(text: "Wind Speed")
    lazy private var windCountLabel: WindSpeedCountLabel = WindSpeedCountLabel()
    private var windCountLabelStoreValue: CGRectStoreValue = CGRectStoreValue()
    
    func buildView() {
        
        let windOffsetX: CGFloat = 40
        let windOffsetY: CGFloat = 55
        let windFrame = CGRect(x: windOffsetX, y: windOffsetY, width: 70, height: 70)
        
        // 创建出扇叶
        threeLineView = ThreeLineView(frame: windFrame)
        self.addSubview(self.threeLineView)
        
        // 移动的头部位
        self.addSubview(self.titleMoveLabel)
        
        // 创建出风速变化的标签
        self.windCountLabel.frame = CGRect(x: 45, y: 155, width: 93, height: 15)
        
        self.addSubview(self.windCountLabel)
        windCountLabelStoreValue.midRect = self.windCountLabel.frame
        windCountLabel.frame.origin.x += 10;
        windCountLabelStoreValue.startRect = self.windCountLabel.frame
        windCountLabel.frame.origin.x -= 10;
        windCountLabel.frame.origin.y -= 10;
        windCountLabelStoreValue.endRect   = self.windCountLabel.frame
        windCountLabel.frame = self.windCountLabelStoreValue.startRect
        windCountLabel.alpha = 0.0
        
        // 创建出支柱
        line.frame = CGRect(x: 0, y: 0, width: 2.0, height: 75.0)
        
        addSubview(self.line)
        line.center.x = self.threeLineView.bounds.width / 2.0
        line.frame.origin.y       = windFrame.size.height / 2.0
        line.frame.origin.x      += windOffsetX;
        line.frame.origin.y      += windOffsetY;
        line.backgroundColor = UIColor.black
        
        let gapFromCenter: CGFloat = 3.0
        //self.line.frame.origin.y + self.line.frame.height + gapFromCenter * 2 * 2
        let startRect = CGRect(x: self.line.frame.origin.x, y: self.line.frame.origin.y + self.line.frame.height + gapFromCenter * 2 * 2 , width: self.line.frame.width, height: 0)
        
        let midRect = CGRect(x: self.line.frame.origin.x, y: self.line.frame.origin.y + gapFromCenter, width: self.line.frame.width, height: self.line.frame.height)

        let endRect = CGRect(x: self.line.frame.origin.x, y: self.line.frame.origin.y, width: self.line.frame.width, height: 0)
       
        lineStoreValue.startRect = startRect
        lineStoreValue.midRect   = midRect
        lineStoreValue.endRect   = endRect
        line.frame               = startRect
        
        // 创建出圆圈
        circleView.frame = CGRect(x: 0, y: 0, width: 4, height: 4)
        circleView.center = CGPoint(x: self.threeLineView.bounds.width / 2.0, y: self.threeLineView.bounds.height / 2.0)
        circleView.layer.cornerRadius = self.circleView.bounds.height / 2.0
        circleView.frame.origin.x += windOffsetX
        circleView.frame.origin.y += windOffsetY
        circleView.backgroundColor = UIColor.black
        self.addSubview(self.circleView)
        circleView.alpha = 0.0

    }
    
    func show() {
        
        let duration: TimeInterval = 1.5
        
        // 扇叶动画
        threeLineView.layer.removeAllAnimations()
        threeLineView.circleByOneSecond = self.circleByOneSecond // 设置转速
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) { 
            self.threeLineView.rotateImageViewWithCircleByOneSecond()
        }
        threeLineView.showWithDuration(durtaion: duration, animated: true)
        
        
        
        
        // 标签数字动画
        self.windCountLabel.toValue = self.windSpeed
        self.windCountLabel.showDuration(duration: duration)
        
        // 标题
        self.titleMoveLabel.show()
        
        // 支柱动画 + 圆动画 + 文本动画 + 标签数字动画
        UIView.animate(withDuration: duration) { 
            self.line.alpha = 1.0
            self.line.frame = self.lineStoreValue.midRect
            
            self.circleView.alpha = 1.0
            
            self.windCountLabel.frame = self.windCountLabelStoreValue.midRect
            self.windCountLabel.alpha = 1.0
        }
    }
    
    func hide() {
        
        let duration: TimeInterval = 0.75;
        
        // 扇叶动画
        self.threeLineView.hideWithDuration(duration: duration, animated: true)
        
        // 标签数字动画
        self.windCountLabel.hideDuration(duration: duration)
        
        // 标题
        self.titleMoveLabel.hide()
        
        // 支柱动画 + 圆动画
        UIView.animate(withDuration: duration, animations: { 
            self.line.alpha = 0.0
            self.line.frame = self.lineStoreValue.endRect
            
            self.circleView.alpha = 0.0
            
            self.windCountLabel.frame = self.windCountLabelStoreValue.endRect
            self.windCountLabel.alpha = 0.0
        }) { (_) in
            
            self.line.frame           = self.lineStoreValue.startRect
            self.windCountLabel.frame = self.windCountLabelStoreValue.startRect
        }
       

        
    }
    

}



































