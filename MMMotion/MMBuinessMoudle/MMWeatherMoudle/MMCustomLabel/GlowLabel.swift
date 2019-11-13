//
//  GlowLabel.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/26.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class GlowLabel: UILabel {
    
    var timer: DispatchSourceTimer?
    var glowViewShowFlag: NSNumber?

    // 定时器的时间间隔，给float值
    var gcdTimerInterval: TimeInterval = 1
    // layer动画的时间长度，给float值
    var glowDuration: TimeInterval = 0.8
    // 设置glowLayer的动画透明度的程度，给float值，范围在[0,1]
    var glowLayerOpacity: Float = 0.8
    
    func createGlowLayerWithColor(color: UIColor, glowRadius: CGFloat) {
        
        /*  UIGraphicsBeginImageContextWithOptions
            使用指定的选项创建一个基于位图的图形上下文。
        */
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        
        //render(in: UIGraphicsGetCurrentContext()): 将图层及其子图层渲染到指定的上下文中。
        self.layer.render(in: UIGraphicsGetCurrentContext()!)

        let path: UIBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        
        color.setFill()
        path.fill(with: .sourceAtop, alpha: 1.0)

        let glowLayer: CALayer = CALayer()
        glowLayer.name = "GlowLaabel"
        glowLayer.frame = self.bounds
        glowLayer.contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        glowLayer.shadowOpacity = 1.0  // 阴影不透明度
        glowLayer.shadowOffset = CGSize(width: 0, height: 0)
        glowLayer.shadowColor = (color == UIColor.clear ? UIColor.red.cgColor : color.cgColor)
        glowLayer.shadowRadius = (glowRadius > 0 ? glowRadius : 2.0)
        glowLayer.opacity = 0.0 // 开始时候的透明度为0
        self.layer.addSublayer(glowLayer)
        UIGraphicsEndImageContext();

    }
    
    func startGlow() {
        
        guard let layers = self.layer.sublayers else {
            return
        }
        for layer in layers {
            
            // 找到了layer才进行下面的操作
            if layer.name == "GlowLaabel" {
                if self.glowViewShowFlag == nil {
                    
                    self.glowViewShowFlag = NSNumber(booleanLiteral: false)
                }
                
                if self.timer == nil {
                    
                    timer?.cancel()
                    timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
                    
                    timer?.scheduleRepeating(deadline: .now(), interval: TimeInterval(self.gcdTimerInterval), leeway: .seconds(0))//.seconds(1))
                    

                    
                    timer?.setEventHandler {
                        
                        if (self.glowViewShowFlag?.boolValue == false) {
                            
                            self.glowViewShowFlag = true
                            
                            // 做动画，从透明到显示出来
                            let animation = CABasicAnimation(keyPath: "opacity")
                            
                            animation.fromValue = 0
                            animation.toValue   = 0.8
                            layer.opacity       = self.glowLayerOpacity
                                
                            
                            animation.duration = self.glowDuration
                       
                            layer.add(animation, forKey: nil)
                          
                            
                        }else {
                            
                            self.glowViewShowFlag = false
                            
                            // 做动画
                            let animation = CABasicAnimation(keyPath: "opacity")
                            animation.fromValue         = layer.opacity
                            animation.toValue           = 0
                            
                            
                                
                            animation.duration = self.glowDuration
                            layer.opacity      = 0
                                
                            layer.add(animation, forKey: nil)
                        }


                        
                    }
                    
                    timer?.resume()
                    
                    
                    
                }
                
            }
        }
        

    }

}
