//
//  WindSpeedCountLabel.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class WindSpeedCountLabel: UIView, NumberCountDelegate {

    
    //起始值
    var fromValue: CGFloat = 0
    
    //结束值
    var toValue: CGFloat = 0
    
    //动画引擎
    private var windSpeedCount: WindSpeedCount?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        windSpeedCount = WindSpeedCount()
        windSpeedCount?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //显示用的label
    lazy private var countLabel: UILabel =  {
        let label: UILabel = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.alpha = 0.0
        self.addSubview(label)
        return label
    }()
    
    //显示动画
    func showDuration(duration: TimeInterval) {
        windSpeedCount?.fromValue = self.fromValue
        windSpeedCount?.toValue   = self.toValue
        windSpeedCount?.duration  = duration
        
        windSpeedCount?.startAnimation()
        
        UIView.animate(withDuration: duration) {
            self.countLabel.alpha = 1.0
        }
    }
    
    //隐藏动画
    func hideDuration(duration: TimeInterval) {
        windSpeedCount?.fromValue = self.toValue;
        windSpeedCount?.toValue   = 0;
        windSpeedCount?.duration  = duration;
        windSpeedCount?.startAnimation()
        
        UIView.animate(withDuration: duration) {
            self.countLabel.alpha = 0.0
        }
        
    }
    
    //MARK: - 数字动画的代理方法
    func numberCount(numberCount: NumberCount, currentString: NSAttributedString) {
        countLabel.attributedText = currentString
    }

}
