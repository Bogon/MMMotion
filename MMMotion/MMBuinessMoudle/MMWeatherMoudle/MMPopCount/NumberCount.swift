//
//  NumberCount.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/24.
//  Copyright © 2017年 王伟奇. All rights reserved.
//
import Foundation
import pop


@objc protocol NumberCountDelegate: NSObjectProtocol {
    
    /// 最原始的方法
    ///
    /// - Parameters:
    ///   - numberCount: 对象自己
    ///   - currentNumber: 变化的值
    @objc optional func numberCount(numberCount: NumberCount, currentNumber: NSNumber)
    
    /// 子类可以实现的方法
    ///
    /// - Parameters:
    ///   - numberCount: 对象自己
    ///   - currentString: 子类返回的富文本
    @objc optional func numberCount(numberCount: NumberCount, currentString: NSAttributedString)
    
}

class NumberCount: NSObject  {
    
    //代理
    weak var delegate: NumberCountDelegate?
    
    //动画实体
    var countAnimation: POPBasicAnimation?
    
     //  初始值
    var fromValue: CGFloat = 0
    
     //  结束值
    var toValue: CGFloat = 0
    
     //  动画持续时间
    var duration: TimeInterval = 0
    
    override init() {
        countAnimation = POPBasicAnimation()
    }
    
     //  开始动画
    func startAnimation() {
        
        // 初始化值
        let fromeValue = self.fromValue
        let toValue    = self.toValue
        let duration: TimeInterval = (self.duration <= 0 ? 1.0 : self.duration)
        
        // 设定动画
        countAnimation?.fromValue = fromeValue
        countAnimation?.toValue = toValue
        
        /* CAMediaTimingFunction 定义动画作为时序曲线的起搏功能。
        CAMediaTimingFunction表示将动画的起搏定义为时序曲线的函数的一个段。该函数将归一化范围[0,1]的输入时间映射到[0,1]范围内的输出时间。
        您可以使用init（controlPoints：_：_：_ :)方法或使用预定义的定时功能之一提供自己的立方Bézier曲线控制点来创建媒体计时功能。
       */
        countAnimation?.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.69, 0.11, 0.32, 0.88)

        countAnimation?.duration = CFTimeInterval(duration)

        // 只有执行了代理才会执行计数引擎
        guard let delegate = delegate, delegate.responds(to: #selector(delegate.numberCount(numberCount:currentNumber:))) else {
            return
        }

        //FixMe:
        // 将计算出来的值通过writeBlock动态给控件设定
        countAnimation?.property = POPMutableAnimatableProperty.property(withName: "countAnimation", initializer: { (prop) in
            prop?.writeBlock = { (_, value) in
                
          //      let number: NSNumber = value?.hashValue as! NSNumber
         //       delegate.numberCount!(numberCount: self, currentNumber: number)
            }

        }) as! POPAnimatableProperty
        
        self.pop_add(self.countAnimation, forKey: nil)

    }
    
}















































