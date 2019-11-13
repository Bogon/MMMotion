//
//  SnowView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/26.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class SnowView: EmitterLayerView {

    var snowImage: UIImage?
    
    var lifetime: Float = 0    // 生命周期
    var birthRate: Float = 0   // 出生率
    var speed: CGFloat = 0       // 雪花速率
    var speedRange: CGFloat = 0  // 速率变化范围 [speed - speedRange , speed + speedRange]
    var gravity: CGFloat = 0     // 重力
    var snowColor: UIColor?  // 雪花颜色
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        emitterLayer = CAEmitterLayer()
        emitterLayer?.frame = self.layer.frame
        
        self.layer.addSublayer(emitterLayer!)
        setup()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        emitterLayer?.emitterShape    = CAEmitterLayerEmitterShape.line                           // 直线粒子发射器
        emitterLayer?.emitterMode     = CAEmitterLayerEmitterMode.surface                         // ?????
        emitterLayer?.emitterSize     = self.frame.size                                // 发射区域
        emitterLayer?.emitterPosition = CGPoint(x: self.bounds.width / 2.0, y: -5)    // 发射中心点位置
    }
    
    func showSnow() {
        
        guard let snowImage = snowImage, let emitterLayer = emitterLayer  else {
            return
        }
        // 创建雪花类型的粒子
        let snowflake: CAEmitterCell = CAEmitterCell()
        
        // 粒子的名字
        snowflake.name = "snow"
        
        // 粒子参数的速度乘数因子
        snowflake.birthRate = (birthRate > 0 ? birthRate : 1.0)
        // 粒子生命周期
        snowflake.lifetime = (lifetime > 0 ? lifetime : 60)
        
        // 粒子速度
        snowflake.velocity = (speed > 0 ? speed : 10.0)
        
        // 粒子的速度范围
        snowflake.velocityRange = (speedRange > 0 ? speedRange : 10.0)
        
        // 粒子y方向的加速度分量(可以理解为重力)
        snowflake.yAcceleration = (gravity != 0 ? gravity : 2.0)
        
        // 每个发射的粒子的初始时候随机的角度
        snowflake.emissionRange = 0.5 * CGFloat.pi
        
        // 粒子旋转角度
        snowflake.spinRange = 0.25 * CGFloat.pi
        
        // 获取图片
        snowflake.contents = snowImage.cgImage
        
        // 设置雪花形状的粒子的颜色
        snowflake.color = (snowColor == nil ? UIColor.white.cgColor : snowColor?.cgColor)
        
        // 尺寸
        snowflake.scale = 0.5
        
        // 尺寸变化范围
        snowflake.scaleRange = 0.3
        
        // 添加粒子
        emitterLayer.emitterCells = [snowflake]
    }
    
    override func show() {
    
        showSnow()
        
        UIView.animate(withDuration: 1.75) { 
            self.alpha = 0.5
        }
    }
    
    override func hide() {
        UIView.animate(withDuration: 0.75, animations: { 
            self.alpha = 0.0
        }) { (_) in
            
        }
    }
    
    override func configType(type: EMitterType) {
        
        if (type == .__SNOW) {
            // 配置
            birthRate = 5.0
            self.snowImage = #imageLiteral(resourceName: "snow")
            self.snowColor = UIColor.black
            self.lifetime  = 30.0
            self.alpha     = 0.0
            
            let snowAlpha: UIImageView = UIImageView(frame: self.bounds)
            snowAlpha.image = #imageLiteral(resourceName: "alpha")
            self.mask = snowAlpha
        }
        
        //下雨效果的动画
        if type == .__RAIN {
            
            let rainAlpha: UIImageView = UIImageView(frame: self.bounds)
            rainAlpha.image = #imageLiteral(resourceName: "alpha")
            
            // 配置
            self.birthRate = 100
            self.speed     = 10
            self.gravity   = 2000
            self.snowImage = #imageLiteral(resourceName: "rain")
            self.snowColor = UIColor.black
            self.lifetime  = 1
            self.mask      = rainAlpha
            self.alpha     = 0
        }
    }


}



































