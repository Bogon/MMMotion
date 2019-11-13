//
//  RotatedAngleView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

// 将度数转换为弧度

//let RADIAN(degrees) = ((M_PI * (degrees))/ 180.f)

// 将弧度转换为度数
//#define   DEGREES(radian)  ((radian) * 180.f / M_PI)
class RotatedAngleView: UIView {

    //默认旋转值
    var defaultTransform: CGAffineTransform!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //存储默认旋转值
        defaultTransform = self.transform
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 旋转角度与持续时间
    ///
    /// - Parameters:
    ///   - angele: 旋转角度
    ///   - duration: 持续时间
    func roateAngle(angele: CGFloat, duration: TimeInterval) {
        
        UIView.animate(withDuration: duration) { 
             self.transform = self.defaultTransform.rotated(by: CGFloat.pi * angele / 180.0)
        }
    }
    
    /// 旋转角度
    ///
    /// - Parameter angele: 旋转角度
    func roateAngle(angele: CGFloat) {
        transform = defaultTransform.rotated(by: CGFloat.pi * angele / 180.0)
    }
    
    /// 恢复动画效果
    ///
    /// - Parameter duration: 恢复的时间
    func recoverDuration(duration: TimeInterval) {
        
        UIView.animate(withDuration: duration, animations: {
            
            self.transform = self.defaultTransform.rotated(by: 0)
        }) { (_) in
            
        }
    }

}





































