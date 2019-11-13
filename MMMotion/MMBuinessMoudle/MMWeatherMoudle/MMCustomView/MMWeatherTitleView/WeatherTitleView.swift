//
//  WeatherTitleView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class WeatherTitleView: UIView {

    private var changeColorLabelStoreValue: CGRectStoreValue = CGRectStoreValue()
    lazy private var vLine = UIView(frame: CGRect(x: 17 - 5, y: 18, width: 6, height: 40))
    lazy private var hLine = UIView()
    lazy private var describInfoLabel = UILabel()
    
    lazy private var changeColorLabel: ChangeColorLabel = ChangeColorLabel(frame: CGRect(x: 35 - 10, y: 23, width: 0, height: 0))
    
    //城市名字
    var cityName: String = ""
    
    //天气描述信息
    var weatherDescription = ""
    
    //天气更新时间
 
    var weatherUpdateTime = "Monday"
    
    func buildView() {
        
        // 颜色设置
        changeColorLabel.textColor = UIColor.black
        changeColorLabel.changedColor = UIColor(hexString: "9000ff")
        changeColorLabel.font = UIFont(name: LATO_REGULAR, size: 24)
        changeColorLabel.updateLabelView()
        changeColorLabel.colorPercent(percent: 0.0)
        changeColorLabel.alpha = 0.0
        self.addSubview(changeColorLabel)
        
        // 垂直的线条
        vLine.backgroundColor = UIColor.black
        vLine.alpha = 0.0
        self.addSubview(vLine)
        
        // 水平的线条
        hLine.frame = CGRect(x: 17 + 10, y: self.vLine.frame.origin.y + self.vLine.frame.height - 1, width: 200, height: 1)
        hLine.alpha = 0.0
        hLine.backgroundColor = UIColor.black
        self.addSubview(hLine)
        
        // 天气描述信息
        describInfoLabel.frame = CGRect(x: 17 + 10, y: vLine.frame.origin.y + vLine.frame.height + 2, width: 200, height: 12)
        describInfoLabel.textAlignment = .right
        describInfoLabel.textColor     = UIColor(hexString: "9000ff")
        describInfoLabel.alpha = 0.0
        describInfoLabel.font = UIFont(name: LATO_BOLD, size: 10.0)
        self.addSubview(describInfoLabel)
        
    }
    
    func show() {
        
        // 更新标题
        changeColorLabel.text = cityName
        changeColorLabel.updateLabelView()
        changeColorLabel.colorPercent(percent: 0.0)
        
        let duration: TimeInterval = 1.75
        
        // 获取天气描述信息
        describInfoLabel.text = weatherDescription
        
        UIView.animate(withDuration: duration, animations: { 
            
            // 城市名字信息
            self.changeColorLabel.frame.origin.x = 35
            self.changeColorLabel.alpha = 1.0
            
            // 垂直的线条
            self.vLine.frame.origin.x = 17
            self.vLine.alpha = 1.0
            
            // 水平的线条
            self.hLine.frame.origin.x = 17
            self.hLine.alpha = 1.0
            
            // 天气描述信息
            self.describInfoLabel.frame.origin.x = 17.0
            self.describInfoLabel.alpha = 1.0
        }) { (_) in
            
        }

    }
    
    func hide() {
        
        // 动画时间
        let duration: TimeInterval = 0.75

        UIView.animate(withDuration: duration, animations: {
            
            // 城市名字信息
            self.changeColorLabel.frame.origin.x = 35 + 10
            self.changeColorLabel.alpha = 0.0
            
            // 垂直的线条
            self.vLine.frame.origin.x = 17 + 5
            self.vLine.alpha = 0.0
            
            // 水平的线条
            self.hLine.frame.origin.x = 17 - 5
            self.hLine.alpha = 0.0
            
            // 天气描述信息
            self.describInfoLabel.frame.origin.x = 17.0 - 10
            self.describInfoLabel.alpha = 0.0
        }) { (_) in
            self.changeColorLabel.frame.origin.x = 35 - 10
            self.vLine.frame.origin.x = 17 - 5
            self.hLine.frame.origin.x = 17 + 10
            self.describInfoLabel.frame.origin.x = 17 + 10
        }
    }
    
    /// 处理偏移量数据
    ///
    /// - Parameter offsetValue: 偏移量
    func accessOffsetValue(offsetValue: CGFloat) {
        
        if (offsetValue <= 0) {
            
            let percent: CGFloat = -offsetValue / 100.0
            
            changeColorLabel.colorPercent(percent: percent)
            
            let tmpX: CGFloat = -offsetValue
            
            self.hLine.frame.origin.x  = 17.0 + tmpX * 0.2
            self.vLine.frame.origin.y  = 18.0 + tmpX * 0.10
            self.changeColorLabel.frame.origin.x = 35 + tmpX * 0.1
            self.describInfoLabel.frame.origin.x = 17.0 - tmpX * 0.05
            
        } else {
            
            let percent: CGFloat = (64 - offsetValue) / 64.0
            
            self.changeColorLabel.alpha = percent
            self.hLine.alpha            = percent
            self.vLine.alpha            = percent
            self.describInfoLabel.alpha = percent
        }

    }
    
}



