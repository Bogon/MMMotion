//
//  DismissingAnimator.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/30.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class DismissingAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 自己的View
        let fromView = transitionContext.view(forKey: .from)
        guard fromView != nil else {
            return
        }
        
        // 动画时间
        let duration = self.transitionDuration(using: transitionContext)
        
        // 开始点 + 结束点
        let startPoint = fromView!.center
        let endPoint = CGPoint(x: fromView!.bounds.width / 2, y: fromView!.bounds.height + Height)
        
        
        // 关键帧动画
        let keyAnimation = CAKeyframeAnimation()
        keyAnimation.keyPath = "position"
        
        keyAnimation.values = calculateFrameFromPoint(fromPoint: startPoint, toPoint: endPoint, frameCount: Int(duration * 60))
        
        keyAnimation.duration = duration
        fromView?.center = endPoint
        fromView?.layer.add(keyAnimation, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            transitionContext.completeTransition(true)
        }
    }
    
    private func calculateFrameFromPoint(fromPoint: CGPoint, toPoint: CGPoint, frameCount: Int) -> [CGPoint] {
        // 设置帧数量
        var values: [CGPoint] = []
        
        // 计算并存储
        var t: CGFloat  = 0.0
        let dt: CGFloat = 1.0 / CGFloat(frameCount - 1)
        for _ in 0..<frameCount {
            // 此处就会根据不同的函数计算出不同的值达到不同的效果
            let x: CGFloat = fromPoint.x + cubicEaseIn(p: t) * (toPoint.x - fromPoint.x)
            let y: CGFloat = fromPoint.y + cubicEaseIn(p: t) * (toPoint.y - fromPoint.y)
            
            // 将计算结果存储进数组中
            values.append(CGPoint(x: x, y: y))
            
            t += dt
        }
        
        // 数组中存储的数据为 NSValue CGPoint 型
        return values
        
    }
    
    private func cubicEaseIn(p: CGFloat) -> CGFloat {
        return p * p * p
    }
   
    
}

