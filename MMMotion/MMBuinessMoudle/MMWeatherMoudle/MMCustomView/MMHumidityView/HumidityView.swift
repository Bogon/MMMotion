//
//  HumidityView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class HumidityView: UIView {

    lazy private var fullCircle: CircleView = CircleView()
    lazy private var showCircle: CircleView = CircleView()
    lazy private var rotateView: RotatedAngleView = RotatedAngleView()
    lazy private var countLabel: HumidityCountLabel = HumidityCountLabel()
    
    lazy private var titleMoveLabel: TitleMoveLabel = TitleMoveLabel.withText(text: "Humidity")
    
    //百分比
    var percent: CGFloat = 0
    
    func buildView() {
        
        let circleRect = CGRect(x: 0, y: 0, width: 115, height: 115)
        let rotateRect = CGRect(x: 45, y: 55, width: circleRect.size.width, height: circleRect.size.height)
        
        //移动的头部
        self.addSubview(titleMoveLabel)
        
        //完整的圆
        fullCircle.frame = circleRect
        fullCircle.lineColor = UIColor(hexString: "C2C2C2")
        fullCircle.buildView()
        
        //局部显示的圆
        showCircle.frame = circleRect
        showCircle.buildView()
        
        //旋转的圆
        rotateView.frame = rotateRect
        rotateView.addSubview(fullCircle)
        rotateView.addSubview(showCircle)
        self.addSubview(rotateView)
        
        //计数的数据
        countLabel.frame = rotateRect
        countLabel.backgroundColor = UIColor.clear
        countLabel.frame.origin.x += 4
        self.addSubview(countLabel)
    }
    
    func show() {
        
        let circleFullPercent: CGFloat = 0.75
        let duration: TimeInterval = 1.5
        
        // 进行参数复位
        fullCircle.strokeEnd(value: 0, animated: false, duration: 0)
        showCircle.strokeEnd(value: 0, animated: false, duration: 0)
        fullCircle.strokeStart(value: 0, animated: false, duration: 0)
        showCircle.strokeStart(value: 0, animated: false, duration: 0)
        rotateView.roateAngle(angele: 0)
        
        // 标题显示
        self.titleMoveLabel.show()
        
        // 设置动画
        fullCircle.strokeEnd(value: circleFullPercent, animated: true, duration: duration)
        showCircle.strokeEnd(value: circleFullPercent * self.percent, animated: true, duration: duration)
        
        rotateView.roateAngle(angele: 45.0, duration: duration)
        countLabel.toValue = percent * 100
        countLabel.showDuration(duration: duration)
    }

    func hide() {
        let circleFullPercent: CGFloat = 0.75
        let duration: TimeInterval = 0.75
        
        //隐藏标题
        self.titleMoveLabel.hide()
        
        fullCircle.strokeStart(value: circleFullPercent, animated: true, duration: duration)
        showCircle.strokeStart(value: circleFullPercent * self.percent, animated: true, duration: duration)
        rotateView.roateAngle(angele: 90.0, duration: duration)
        countLabel.hideDuration(duration: duration)
        
    }
}























