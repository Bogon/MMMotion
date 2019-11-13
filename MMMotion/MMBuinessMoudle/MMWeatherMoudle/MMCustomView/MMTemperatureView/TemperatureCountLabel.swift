//
//  TemperatureCountLabel.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class TemperatureCountLabel: UIView, NumberCountDelegate {
    
    //显示用的label
    lazy private var countLabel = UILabel()

    //初始值
    private var fromValue: CGFloat = 0
    
    //结束值
    var toValue: CGFloat = 0
    
    //动画引擎
    var temperatureCount: TemperatureCount?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        countLabel.frame = self.bounds
        countLabel.textAlignment = .center
        self.addSubview(countLabel)
        
        countLabel.alpha = 0.0
        countLabel.numberOfLines = 0
        
        temperatureCount = TemperatureCount()
        temperatureCount?.delegate = self
        
        
    }
    
    //MARK: - 数字动画的代理方法
    func numberCount(numberCount: NumberCount, currentString: NSAttributedString) {
        countLabel.attributedText = currentString
    }

 
    
    //显示动画
    func showDuration(duration: TimeInterval) {
        
        temperatureCount?.fromValue = fromValue
        temperatureCount?.toValue = toValue
        temperatureCount?.duration = duration
        
        temperatureCount?.startAnimation()
        
        UIView.animate(withDuration: TimeInterval(duration)) { 
            self.countLabel.alpha = 1.0
        }
    }
    
    //隐藏动画
    func hideDuration(duration: TimeInterval) {
        temperatureCount?.fromValue = toValue
        temperatureCount?.toValue = 0
        temperatureCount?.duration = duration
        temperatureCount?.startAnimation()
        
        UIView.animate(withDuration: duration) {
            self.countLabel.alpha = 0.0
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}




























