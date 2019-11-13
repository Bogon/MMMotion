//
//  HumidityCountLabel.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class HumidityCountLabel: UIView, NumberCountDelegate {

    //显示用的label
    lazy private var countLabel = UILabel()
    
    //初始值
    private var fromValue: CGFloat = 0
    
    //动画引擎 
    var humidityCount: HumidityCount?
    
    //结束值
    var toValue: CGFloat = 0
    
    override var frame: CGRect {
        didSet{
            countLabel.frame = self.bounds
            countLabel.textAlignment = .center
            self.addSubview(countLabel)
            
            countLabel.alpha = 0.0
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        humidityCount = HumidityCount()
        humidityCount?.delegate = self
        
    }
    
    //MARK: - 数字动画的代理方法
    func numberCount(numberCount: NumberCount, currentString: NSAttributedString) {
        countLabel.attributedText = currentString
    }
    
    
    
    //显示动画
    func showDuration(duration: TimeInterval) {
        
        humidityCount?.fromValue = self.fromValue
        humidityCount?.toValue = self.toValue
        humidityCount?.duration = duration
        humidityCount?.startAnimation()
        /*
         用于绘制2D图形的仿射变换矩阵。
         仿射变换矩阵用于旋转，缩放，平移或偏移在图形上下文中绘制的对象。 CGAffineTransform类型提供了创建，连接和应用仿射变换的功能。
         仿射变换由3乘3矩阵表示：
         因为第三列总是（0,0,1），CGAffineTransform数据结构只包含前两列的值。
         在概念上，仿射变换将表示图中每个点（x，y）的行向量乘以该矩阵，产生表示对应点（x'，y'）的向量：
         给定3×3矩阵，使用以下等式将一个坐标系中的点（x，y）变换为另一坐标系中的合成点（x'，y'）。
         因此，矩阵“链接”两个坐标系，它指定了一个坐标系中的点如何映射到另一个坐标系中的点。
         请注意，您通常不需要直接创建仿射变换。例如，如果您只想绘制一个缩放或旋转的对象，则不需要构建仿射变换。通过运动，缩放或旋转操作图形的最直接的方法是分别调用函数translateBy（x：y :)，scaleBy（x：y :)或rotate（by :)。一般来说，如果要稍后重用它，通常只能创建仿射变换。
        CGAffineTransform*/
        countLabel.transform = CGAffineTransform(a: 1.5, b: 0, c: 0, d: 1.5, tx: 0, ty: 0)
        
        UIView.animate(withDuration: TimeInterval(duration)) {
            
            self.countLabel.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
            self.countLabel.alpha = 1.0
        }
    }
    
    //隐藏动画
    func hideDuration(duration: TimeInterval) {
        humidityCount?.fromValue = self.toValue
        humidityCount?.toValue = 0
        humidityCount?.duration = duration
        humidityCount?.startAnimation()
        
        UIView.animate(withDuration: TimeInterval(duration)) {
            
            self.countLabel.transform = CGAffineTransform(a: 0.5, b: 0, c: 0, d: 0.5, tx: 0, ty: 0)
            self.countLabel.alpha = 0.0
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}






















