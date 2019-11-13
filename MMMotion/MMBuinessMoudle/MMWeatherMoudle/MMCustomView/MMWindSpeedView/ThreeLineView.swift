//
//  ThreeLineView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ThreeLineView: UIView {

    private var oneLine: AnimatedLineView!
    private var twoLine: AnimatedLineView!
    private var threeLine: AnimatedLineView!
    
    //风的速度
    var circleByOneSecond: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLineViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(eventDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(eventDidBecomeActive(notification:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(eventDidBecomeActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    func initLineViews() {
        
        let image = #imageLiteral(resourceName: "WindSpeed")
        let width: CGFloat = self.bounds.height / image.size.height * image.size.width / 2.0
        
        // 初始化第一个叶子
        oneLine = AnimatedLineView(frame:CGRect(x: 0, y: 0, width: width, height: self.bounds.height))
        oneLine.image = image
        oneLine.center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        self.addSubview(oneLine)
        
        // 初始化第二个叶子
        twoLine = AnimatedLineView(frame:CGRect(x: 0, y: 0, width: width, height: self.bounds.height))
        twoLine.image  = image
        twoLine.center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        self.addSubview(twoLine)
        twoLine.transform = self.twoLine.transform.rotated(by: CGFloat.pi * 120.0 / 180.0);
        
        // 初始化第三个叶子
        threeLine = AnimatedLineView(frame:CGRect(x: 0, y: 0, width: width, height: self.bounds.height))
        threeLine.image  = image
        threeLine.center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        self.addSubview(threeLine)
        threeLine.transform = self.twoLine.transform.rotated(by: CGFloat.pi * 120.0 / 180.0);
        
    }


    
    /// 显示出来
    ///
    /// - Parameters:
    ///   - durtaion: 动画持续时间
    ///   - animated: 是否执行动画
    func showWithDuration(durtaion: TimeInterval, animated: Bool) {
        
        oneLine.showWithDuration(duration: durtaion, animated: animated)
        twoLine.showWithDuration(duration: durtaion, animated: animated)
        threeLine.showWithDuration(duration: durtaion, animated: animated)
    }
    
    /// 隐藏
    ///
    /// - Parameters:
    ///   - durtaion: 动画持续时间
    ///   - animated: 是否执行动画
    func hideWithDuration(duration: TimeInterval, animated: Bool) {
        oneLine.hideWithDuration(duration: duration, animated: animated)
        twoLine.hideWithDuration(duration: duration, animated: animated)
        threeLine.hideWithDuration(duration: duration, animated: animated)
    }
    
    //一秒钟旋转几圈
    func rotateImageViewWithCircleByOneSecond() {
        let circleByOneSecond: CGFloat = (self.circleByOneSecond <= 0 ? 0.001 : self.circleByOneSecond)
        
        
        //旋转动画效果 制作过程
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.fromValue = 0
        anim.toValue = 100000 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = (CFTimeInterval(1 / circleByOneSecond)) * 100000
        
        //动画完成不删除，如果 iconView 被释放，动画会一起被销毁
        //在连续播放动画的非常有用
        anim.isRemovedOnCompletion = false
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        //将动画加入到图层
        self.layer.add(anim, forKey: nil)
        
    }
    
    @objc private func eventDidBecomeActive(notification: Notification) {
        
        if notification.name == UIApplication.didBecomeActiveNotification {
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.alpha = 1.0
            })
            
            self.rotateImageViewWithCircleByOneSecond()
            
        }else if notification.name == UIApplication.didEnterBackgroundNotification{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0.0
            })
        }else if notification.name == UIApplication.willResignActiveNotification{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0.0
            })
        }
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
























