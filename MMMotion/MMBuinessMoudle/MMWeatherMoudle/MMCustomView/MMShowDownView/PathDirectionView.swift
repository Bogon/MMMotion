//
//  PathDirectionView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/30.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class PathDirectionView: UIView {
    
    //起始点在右边
    var startPointAtRight = false
    
    private var shapeLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shapeLayer = CAShapeLayer()
        guard let shapelayer = shapeLayer else{
            return
        }
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.strokeColor = UIColor.red.cgColor
        shapelayer.lineWidth = 1
        shapelayer.strokeEnd = 0
        shapelayer.opacity   = 0
        shapelayer.path = createPathWithHeight(height: 0)
        self.layer.addSublayer(shapelayer)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建出贝塞尔曲线
    ///
    /// - Parameter height: 高度
    /// - Returns: 返回贝塞尔曲线
    private func createPathWithHeight(height: CGFloat) -> CGPath {
        
        let bezierPath = UIBezierPath()
        
        var startPoint = CGPoint.zero
        var endPoint   = CGPoint.zero
        
        if (self.startPointAtRight == false) {
            
            startPoint = CGPoint(x: self.frame.width, y: height)
            
        } else {
            
            startPoint = CGPoint(x: 0, y: height)
            endPoint = CGPoint(x: self.frame.width, y: 0)

        }
        
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
        
        return bezierPath.cgPath
    }
    
    //根据百分比显示
    func showPercent(percent: CGFloat) {
        
        guard let shapeLayer = self.shapeLayer else {
            return
        }
        
        if (percent < 0) {
            
            shapeLayer.path      = createPathWithHeight(height: 0)
            shapeLayer.strokeEnd = 0
            shapeLayer.opacity   = 0
            
        } else if (percent >= 0 && percent <= 0.5) { // [0, 0.5]
            
            shapeLayer.path      = createPathWithHeight(height: 0)
            shapeLayer.strokeEnd = percent * 2
            shapeLayer.opacity   = Float(percent * 2)
            
        } else if (percent <= 1) { // (0.5, 1]
            
            let currentPercent: CGFloat = percent - 0.5
            shapeLayer.path      = createPathWithHeight(height: currentPercent * self.frame.height * 2)
            shapeLayer.strokeEnd = 1
            shapeLayer.opacity   = 1
            
        } else { // (1, +无穷大)
            
            shapeLayer.path      = createPathWithHeight(height: self.frame.height)
            shapeLayer.strokeEnd = 1   //行程结束
            shapeLayer.opacity   = 1  //不透明度
        }

    }
   
}
