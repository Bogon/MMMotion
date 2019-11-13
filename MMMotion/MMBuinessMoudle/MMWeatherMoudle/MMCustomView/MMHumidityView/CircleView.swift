//
//  CircleView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    //原型layer
    private var circleLayer: CAShapeLayer?

    //线条宽度
    var lineWidth: CGFloat = 2
    
    //线条颜色
    var lineColor: UIColor?
    
    //旋转方向
    var clockWise: Bool = true
    
    //开始的角度
    var startAngle: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCircleLayer()
    }
    
    //创建layer
    private func createCircleLayer() {
        
        circleLayer = CAShapeLayer()
        
        circleLayer?.frame = self.bounds
        
        self.layer.addSublayer(circleLayer!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        
        // 初始化信息
        let lineWidth: CGFloat = self.lineWidth <= 0 ? 1 : self.lineWidth
        let lineColor: UIColor = self.lineColor == nil ? UIColor.black : self.lineColor!
        let size: CGSize = self.bounds.size
        let radius: CGFloat = size.width / 2.0 - lineWidth / 2.0 // 设置半径(刚好贴到frame上面去)
        
        
        // 旋转方向
        let clockWise = self.clockWise
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 0
        

        
        // 将弧度转换为度数
    //    #define   DEGREES(radian)  ((radian) * 180.f / M_PI)
        if (clockWise == true) {
            
            //FixMe:
            // 将度数转换为弧度
            startAngle = 0//-(180.0 - self.startAngle) / 180.0 * CGFloat.pi
            endAngle   = 2 * CGFloat.pi//(180.0 - self.startAngle) / 180.0 * CGFloat.pi
            
        } else {
            
            // 将度数转换为弧度
            startAngle = CGFloat.pi * (180.0 - self.startAngle) / 180.0
            endAngle   = -CGFloat.pi * (180.0 + self.startAngle) / 180.0
        }
        
        // 创建出贝塞尔曲线
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: size.height / 2.0, y: size.width / 2.0), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        
        
        
        // 获取path
        circleLayer?.path = circlePath.cgPath
        
        // 设置颜色
        circleLayer?.strokeColor = lineColor.cgColor
        circleLayer?.fillColor   = UIColor.clear.cgColor
        circleLayer?.lineWidth   = lineWidth
        circleLayer?.strokeEnd   = 0.0

    }
    
    /// 做stroke动画
    ///
    /// - Parameters:
    ///   - value: 取值【0，1】
    ///   - animated: 是否动画
    ///   - duration: 动画执行时间
    func strokeEnd(value: CGFloat, animated: Bool, duration: TimeInterval) {
        
        var value = value
        // 过滤掉不合理的值
        if (value <= 0) {
            
            value = 0
            
        } else if (value >= 1) {
            
            value = 1.0
        }
        
        if (animated) {
            /*
             CAKeyframeAnimation
             您使用继承的init（keyPath :)方法创建一个CAKeyframeAnimation对象，指定要在图层上设置动画的属性的键路径。 然后，您可以指定用于控制时序和动画行为的关键帧值。
             
             对于大多数类型的动画，您可以使用值和keyTimes属性指定关键帧值。 在动画过程中，Core Animation通过在您提供的值之间插值来生成中间值。 当对作为坐标点的值（例如图层的位置）进行动画处理时，可以指定该点跟随的路径，而不是单个值。 动画节奏由您提供的时间信息控制。
 */
            // 关键帧动画
            let keyAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
            keyAnimation.duration = duration
            
           keyAnimation.values = calculateFrameFromValue(fromValue: (self.circleLayer?.strokeEnd)!, toValue: value, frameCount: Int(duration * 30))

            
            // 执行动画
            circleLayer?.strokeEnd = value
            circleLayer?.add(keyAnimation, forKey: nil)
            
        } else {
            
            /*
             CATransaction 事务类,可以对多个layer的属性同时进行修改.它分隐式事务,和显式事务.
             区分隐式动画和隐式事务：隐式动画通过隐式事务实现动画 。
             
             区分显式动画和显式事务：显式动画有多种实现方式，显式事务是一种实现显式动画的方式。
 */
            // 关闭动画 隐式动画的关闭
            CATransaction.setDisableActions(true)
            circleLayer?.strokeEnd = value
            CATransaction.setDisableActions(false)
        }

    }
    


    
    func strokeStart(value: CGFloat, animated: Bool, duration: TimeInterval) {
        
        var value = value
        // 过滤掉不合理的值
        if (value <= 0) {
            
            value = 0
            
        } else if (value >= 1) {
            
            value = 1.0
        }
        
        if (animated) {
            
            // 关键帧动画
            let keyAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
            keyAnimation.duration = duration
            
            keyAnimation.values = calculateFrameFromValue(fromValue: (self.circleLayer?.strokeStart)!, toValue: value, frameCount: Int(duration * 30))
            
            // 执行动画
            circleLayer?.strokeStart = value
            circleLayer?.add(keyAnimation, forKey: nil)
            // 执行动画

            
        } else {
            
            // 关闭动画 隐式动画的关闭
            CATransaction.setDisableActions(true)
            circleLayer?.strokeStart = value
            CATransaction.setDisableActions(false)
        }

    }
    
    /**
     *  创建出默认配置的view
     *
     *  @param frame 设置用的frame值
     *
     *  @return 实例对象
     */
    class func createDefauleViewWithFrame(frame: CGRect) -> CircleView {
        let circleView = CircleView(frame: frame)
        circleView.lineWidth   = 2.0
        circleView.lineColor   = UIColor.black
        circleView.clockWise   = true
        circleView.startAngle  = 180
        
        return circleView
    }
    
    
    
    
    private func cubicEaseInOut(p: CGFloat) -> CGFloat {
        if p < 0.5 {
            return 4 * p * p * p
        }else {
            let f: CGFloat = ((2 * p) - 2)
            return 0.5 * f * f * f + 1
        }
    }
    private func calculateFrameFromValue(fromValue: CGFloat, toValue: CGFloat, frameCount: Int) -> [CGFloat] {
        
        
        
        // 设置帧数量
        var values: [CGFloat] = []
        
        // 计算并存储
        var t: CGFloat = 0.0
        let dt: CGFloat = 1.0 / CGFloat(frameCount - 1)
        
        for _ in 0..<frameCount {
            // 此处就会根据不同的函数计算出不同的值达到不同的效果
            let value = fromValue + cubicEaseInOut(p: t) * (toValue - fromValue)
            
            // 将计算结果存储进数组中
            values.append(value)
            
            t += dt
        }
        
        // 数组中存储的数据为
        return values
        
    }

}



















