//
//  MinTempCount.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/25.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import pop

class MinTempCount: NumberCount {
    
    override func startAnimation() {
        // 初始化值
        let fromeValue = self.fromValue
        let toValue    = self.toValue
        let duration: TimeInterval = (self.duration <= 0 ? 1.0 : self.duration)
        
        // 设定动画
        countAnimation?.fromValue = fromeValue
        countAnimation?.toValue = toValue
        
        /*
         CAMediaTimingFunction 定义动画作为时序曲线的起搏功能。
         CAMediaTimingFunction表示将动画的起搏定义为时序曲线的函数的一个段。该函数将归一化范围[0,1]的输入时间映射到[0,1]范围内的输出时间。
         您可以使用init（controlPoints：_：_：_ :)方法或使用预定义的定时功能之一提供自己的立方Bézier曲线控制点来创建媒体计时功能。
         */
        countAnimation?.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.69, 0.11, 0.32, 0.88)
        
        countAnimation?.duration = CFTimeInterval(duration)
        
        // 只有执行了代理才会执行计数引擎
        guard let delegate = delegate, delegate.responds(to: #selector(delegate.numberCount(numberCount:currentString:))) else {
            return
        }
        
        // 将计算出来的值通过writeBlock动态给控件设定
        countAnimation?.property = POPMutableAnimatableProperty.property(withName: "countAnimation", initializer: { (prop) in
            
            prop?.writeBlock = { (aaa, value) in
                guard let value = value else {
                    delegate.numberCount!(numberCount: self, currentString: NSAttributedString(string: "0"))
                    return
                }
                let number: Int = Int(value.pointee)
                let ats = self.accessNumber(number: number)
                delegate.numberCount!(numberCount: self, currentString: ats)
            }
            
        }) as! POPAnimatableProperty
        
        self.pop_add(self.countAnimation, forKey: nil)
    }
    
    // 处理富文本
    private func accessNumber(number: Int) -> NSAttributedString {
        
        let countStr: String = "\(number)"
        let preStr: String = "Min "
        
        let totalStr = preStr + countStr
        
        let font1: UIFont = UIFont(name: LATO_REGULAR, size: 12.0)!
        let font2: UIFont = UIFont(name: LATO_BOLD, size: 8.0)!
        
        let totalRange: NSRange = totalStr.range()             // 全局的区域
        let countRange: NSRange = countStr.rangeFrom(string: totalStr) // 数字的区域
        
        return totalStr.createAttributedStringAndConfig(configs: [
            //全局设置
            ConfigAttributedString.font(font: font2, range: totalRange),
            ConfigAttributedString.font(font: font1, range: countRange),
            
            //局部设置
            ConfigAttributedString.foregroundColor(color: UIColor.black, range: totalRange)
            ])
        
    }
}

