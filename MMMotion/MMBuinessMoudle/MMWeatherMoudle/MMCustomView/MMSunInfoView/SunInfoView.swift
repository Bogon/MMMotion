//
//  SunInfoView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class SunInfoView: UIView {

    //日出的值
    var sunsireValue: SunriseAndSunset = SunriseAndSunset()
    //日落的值
    var sunsetValue: SunriseAndSunset = SunriseAndSunset()
    
    private var sunriseViewStoreValue = CGRectStoreValue()
    private var sunsetViewStoreValue = CGRectStoreValue()
    
    lazy private var movetitleLabel = TitleMoveLabel.withText(text: "Sunrise/Sunset")
    
    lazy private var sunriseView: SunriseView = SunriseView()
    lazy private var sunriseTimeLabel = UILabel()
    
    lazy private var sunsetView: SunsetView = SunsetView()
    lazy private var sunsetTimeLabel = UILabel()
    
    
    func buildView() {
        
        movetitleLabel.buildView()
        self.addSubview(movetitleLabel)
        
        // 日出的view
        self.sunriseView.frame = CGRect(x: 50, y: 55, width: 50, height: 100)
        self.sunriseView.buildView()
        self.addSubview(self.sunriseView)
        
        self.sunriseViewStoreValue.midRect   = self.sunriseView.frame
        self.sunriseView.frame.origin.y     += 10;
        self.sunriseViewStoreValue.startRect = self.sunriseView.frame
        self.sunriseView.frame.origin.y     -= 20;
        self.sunriseViewStoreValue.endRect   = self.sunriseView.frame
        self.sunriseView.frame = self.sunriseViewStoreValue.startRect
        
        // 日出时间标签
        self.sunriseTimeLabel.frame = CGRect(x: 0, y: 50, width: 50, height: 25)
        self.sunriseTimeLabel.alpha         = 0.0
        self.sunriseTimeLabel.textAlignment = .center
        self.sunriseTimeLabel.font          = UIFont(name: LATO_BOLD, size: 10)
        self.sunriseView.addSubview(sunriseTimeLabel)

        // 日落的view
        self.sunsetView.frame = CGRect(x: 110, y: 60, width: 50, height: 100)
        self.sunsetView.buildView()
        self.addSubview(self.sunsetView)
        
        self.sunsetViewStoreValue.midRect   = self.sunsetView.frame
        self.sunsetView.frame.origin.y     -= 10
        self.sunsetViewStoreValue.startRect = self.sunsetView.frame
        self.sunsetView.frame.origin.y     += 20
        self.sunsetViewStoreValue.endRect   = self.sunsetView.frame
        self.sunsetView.frame = self.sunsetViewStoreValue.startRect
        
        //日落标签
        self.sunsetTimeLabel.frame = CGRect(x: 0, y: 20, width: 50, height: 25)
        self.sunsetTimeLabel.textAlignment = .center
        self.sunsetTimeLabel.alpha = 0.0
        self.sunsetTimeLabel.font = UIFont(name: LATO_BOLD, size: LATO_10)
        self.sunsetView.addSubview(self.sunsetTimeLabel)
 
    }
    
    func show() {
        
        self.movetitleLabel.show()
        
        //动画持续时间
        let duration: TimeInterval = 1.75
        
        // 日出动画
        sunriseView.showWithDuration(duration: 1.5)
        
        // 日落动画
        sunsetView.showWithDuration(duration: 1.5)
        
        
        UIView.animate(withDuration: duration) {
            self.sunriseView.frame = self.sunriseViewStoreValue.midRect
            self.sunsetView.frame  = self.sunsetViewStoreValue.midRect
            
            self.sunriseTimeLabel.text  = self.sunsireValue.timeString
            self.sunriseTimeLabel.alpha = 1.0
            
            self.sunsetTimeLabel.text   = self.sunsetValue.timeString
            self.sunsetTimeLabel.alpha  = 1.0
        }
        
    }

    func hide() {
        
        let duration: TimeInterval = 0.75
        self.movetitleLabel.hide()
        
        // 日出动画隐藏
        sunriseView.hideWithDuration(duration: duration)
        
        // 日落动画隐藏
        sunsetView.hideWithDuration(duration: duration)
        
        
        UIView.animate(withDuration: duration, animations: {
            self.sunriseView.frame = self.sunriseViewStoreValue.endRect
            self.sunsetView.frame  = self.sunsetViewStoreValue.endRect
            
            self.sunriseTimeLabel.alpha = 0.0
            self.sunsetTimeLabel.alpha  = 0.0
        }) { (_) in
            self.sunriseView.frame = self.sunriseViewStoreValue.startRect
            self.sunsetView.frame = self.sunsetViewStoreValue.startRect
        }
        
    }
}







































