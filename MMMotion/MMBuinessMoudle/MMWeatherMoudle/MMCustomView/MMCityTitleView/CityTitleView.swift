//
//  CityTitleView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/28.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class CityTitleView: UIView {

    var cityName: String? {
        didSet{
            cityNameLabel.text = cityName
            cityNameLabel.sizeToFit()
        }
    }
    var cityCode: String?
    var weatherDescription: String?{
        didSet{
            weatherDesLabel.text = weatherDescription
            weatherDesLabel.sizeToFit()
        }
    }
    var baseStation: String?{
        didSet{
            baseLabel.text = baseStation
        }
    }
    var updateYear: String?
    var updateHour: String?
    var utcSec: TimeInterval = 0 {
        didSet{
            let utcDate: Date = Date.init(timeIntervalSince1970: utcSec)
            let formatter = DateFormatter()
            
            formatter.dateFormat = "yyyy.MM.dd"
            let yearStr = formatter.string(from: utcDate)
            self.updateYearLabel.text = yearStr
            
            formatter.dateFormat = "hh:mm"
            let hourStr = formatter.string(from: utcDate) + " update"
            self.updateHourLabel.text = hourStr
        }
        
    }
    var weatherNumber: Int = 800
    
    lazy private var baseLabel = UILabel()       // 基站label
    private var baseLabelStoreValue: CGRectStoreValue = CGRectStoreValue()
    
    lazy private var cityNameLabel = UILabel()  // 城市名字label
    private var cityNameLabelStoreValue: CGRectStoreValue = CGRectStoreValue()
    
    lazy private var weatherDesLabel = UILabel() // 天气描述label
    private var weatherDesLabelStoreValue: CGRectStoreValue = CGRectStoreValue()

    lazy private var updateYearLabel = UILabel() // 更新年份label
    private var updateYearLabelStoreValue: CGRectStoreValue = CGRectStoreValue()

    lazy private var updateHourLabel = UILabel() // 更新的小时label
    private var updateHourLabelStoreValue: CGRectStoreValue = CGRectStoreValue()

    lazy private var blackView = UILabel()      // 黑色的view
    private var blackViewStoreValue: CGRectStoreValue = CGRectStoreValue()

    lazy private var redView = UILabel()         // 红色的view
    private var redViewStoreValue: CGRectStoreValue = CGRectStoreValue()
 
    //天气标题效果动画（下雪的和下雨的动画）
    private var weatherConditionView: EmitterLayerView? //= EmitterLayerView(frame: CGRect(x: 0, y: 0, width: Width / 2, height: Height - Width - Width / 2))
    
    func buildView() {
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        // 基站信息
        baseLabel.frame = CGRect(x: 0, y: 5, width: Width - 8, height: 12.0)
        baseLabel.textAlignment = .right
        baseLabel.font = UIFont(name: LATO_BOLD, size: 10.0)//[UIFont fontWithName:LATO_BOLD size:10.f];
        baseLabel.text = "cmc station"
        moveToLeftWithMidRect(rect: baseLabel.frame, moveDistance: 10, withStoreValue: baseLabelStoreValue)
        baseLabel.frame         = self.baseLabelStoreValue.startRect
        baseLabel.alpha         = 0
        self.addSubview(baseLabel)
        
        //黑色的view
        blackView.frame = CGRect(x: -30, y: 22, width: 35, height: 60)
        blackView.backgroundColor     = UIColor.black
        self.addSubview(blackView)
        blackViewStoreValue.midRect = blackView.frame
        blackView.frame.origin.x -= 5
        baseLabelStoreValue.startRect = blackView.frame
        blackView.frame.origin.x += 5
        blackView.frame.origin.y += 5
        baseLabelStoreValue.endRect = blackView.frame
        blackView.frame = blackViewStoreValue.startRect
        blackView.alpha = 0
        
        // 红色的view
        redView.frame = CGRect(x: Width - 135, y: 22, width: 135 + 100, height: 60)
        redView.backgroundColor = UIColor.red
        self.addSubview(redView)
        moveToLeftWithMidRect(rect: redView.frame, moveDistance: 30, withStoreValue: redViewStoreValue)
        redView.frame = redViewStoreValue.startRect
        redView.alpha = 0

        // 年份的view
        updateYearLabel.frame = CGRect(x: 0, y: 30, width: Width - 40, height: 18)
        updateYearLabel.text = "2015.03.21"
        updateYearLabel.textAlignment = .right
        updateYearLabel.textColor = UIColor.white
        updateYearLabel.font = UIFont(name: LATO_LIGHT, size: 16)
        self.addSubview(updateYearLabel)
        moveToLeftWithMidRect(rect: updateYearLabel.frame, moveDistance: 20, withStoreValue: updateYearLabelStoreValue)
        updateYearLabel.frame = self.updateYearLabelStoreValue.startRect
        updateYearLabel.alpha = 0
        
        // 小时的view
        updateHourLabel.frame = CGRect(x: 0, y: 55, width: Width - 8, height: 20)
        updateHourLabel.textAlignment = .right
        updateHourLabel.text = "13:20 update"
        updateHourLabel.textColor = UIColor.white
        updateHourLabel.font = UIFont(name: LATO_REGULAR, size: 16)
        self.addSubview(updateHourLabel)
        moveToLeftWithMidRect(rect: updateHourLabel.frame, moveDistance: 15, withStoreValue: updateHourLabelStoreValue)
        updateHourLabel.frame = updateHourLabelStoreValue.startRect
        updateHourLabel.alpha = 0
        
        // 城市label
        cityNameLabel.frame = CGRect(x: 12, y: 17, width: Width - 10, height: 40)
        cityNameLabel.text = "San Francisco"
        cityNameLabel.font = UIFont(name: LATO_LIGHT, size: 30)
        self.addSubview(cityNameLabel)
        cityNameLabel.sizeToFit()
             //  cityNameLabel.width = Width - 10;
        moveToRightWithMidRect(rect: cityNameLabel.frame, moveDistance: 5, withStoreValue: cityNameLabelStoreValue)
        cityNameLabel.frame = self.cityNameLabelStoreValue.startRect
        cityNameLabel.alpha = 0
        
        // 天气描述用的label
        weatherDesLabel.frame = CGRect(x: 15, y: 62, width: Width - 10, height: 20)
        weatherDesLabel.text = "broken clouds      "
        weatherDesLabel.font = UIFont(name: LATO_THIN, size: 16)
        self.addSubview(weatherDesLabel)
        weatherDesLabel.sizeToFit()
        //self.weatherDesLabel.width = Width - 10;
        moveToRightWithMidRect(rect: weatherDesLabel.frame, moveDistance: 8, withStoreValue: weatherDesLabelStoreValue)
        weatherDesLabel.frame = self.weatherDesLabelStoreValue.startRect
        weatherDesLabel.alpha = 0
    }
    
    func show() {
        
        let duration: TimeInterval = 1.75
        let type: EMitterType = WeatherNumberMeaningTransform.emitterTypeWithNumber(number: weatherNumber)
        
        // 表述类型(title上的动画效果表示下雨或者下雪)
        if (type == .__RAIN) {
            
            self.weatherConditionView = SnowView(frame: CGRect(x: 0, y: 0, width: Width / 2, height: Height - Width - Width / 2))
            self.weatherConditionView?.configType(type: .__RAIN)
            self.weatherConditionView?.show()
            self.addSubview(self.weatherConditionView!)
            
        } else if (type == .__SNOW) {
            
            self.weatherConditionView = SnowView(frame: CGRect(x: 0, y: 0, width: Width / 2, height: Height - Width - Width / 2))
            self.weatherConditionView?.configType(type: .__SNOW)
            self.weatherConditionView?.show()
            self.addSubview(self.weatherConditionView!)
            
        } else if (type == .__NONE) {
            
        }
        
        UIView.animate(withDuration: duration) {
            self.baseLabel.frame = self.baseLabelStoreValue.midRect
            self.baseLabel.alpha = 1
            
            self.cityNameLabel.frame = self.cityNameLabelStoreValue.midRect
            self.cityNameLabel.alpha = 1
            
            self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.midRect
            self.weatherDesLabel.alpha = 1
            
            self.updateYearLabel.frame = self.updateYearLabelStoreValue.midRect
            self.updateYearLabel.alpha = 1
            
            self.updateHourLabel.frame = self.updateHourLabelStoreValue.midRect
            self.updateHourLabel.alpha = 1
            
            self.redView.frame = self.redViewStoreValue.midRect
            self.redView.alpha = 1
            
            self.blackView.frame = self.blackViewStoreValue.midRect
            self.blackView.alpha = 1

        }

    }
    
    func hide() {
        let duration: TimeInterval = 0.75
        
        weatherConditionView?.hide()
        
        UIView.animate(withDuration: duration, animations: { 
            self.baseLabel.frame = self.baseLabelStoreValue.endRect
            self.baseLabel.alpha = 0
            
            self.cityNameLabel.frame = self.cityNameLabelStoreValue.endRect
            self.cityNameLabel.alpha = 0
            
            self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.endRect
            self.weatherDesLabel.alpha = 0
            
            self.updateYearLabel.frame = self.updateYearLabelStoreValue.endRect
            self.updateYearLabel.alpha = 0
            
            self.updateHourLabel.frame = self.updateHourLabelStoreValue.endRect
            self.updateHourLabel.alpha = 0
            
            self.redView.frame = self.redViewStoreValue.endRect
            self.redView.alpha = 0
            
            self.blackView.frame = self.blackViewStoreValue.endRect
            self.blackView.alpha = 0
        }) { (_) in
            self.baseLabel.frame       = self.baseLabelStoreValue.startRect
            
            self.cityNameLabel.frame   = self.cityNameLabelStoreValue.startRect
            
            self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.startRect
            
            self.updateYearLabel.frame = self.updateYearLabelStoreValue.startRect
            
            self.updateHourLabel.frame = self.updateHourLabelStoreValue.startRect
            
            self.redView.frame = self.redViewStoreValue.startRect
            
            self.blackView.frame = self.blackViewStoreValue.startRect
            self.blackView.alpha = 1
            
            // 移除天气view
            self.weatherConditionView?.removeFromSuperview()
        }
        
    }
    
    
    // 从右向左运动
    private func moveToLeftWithMidRect(rect: CGRect, moveDistance: CGFloat, withStoreValue: CGRectStoreValue) {
        
        let midRect = rect
        let startRect = CGRect(x: rect.origin.x + moveDistance, y: rect.origin.y, width: rect.width, height: rect.height)
        let endRect = CGRect(x: rect.origin.x - moveDistance, y: rect.origin.y, width: rect.width, height: rect.height)
            
        withStoreValue.midRect   = midRect
        withStoreValue.startRect = startRect
        withStoreValue.endRect   = endRect
    }
    
    // 从左向右运动
    private func moveToRightWithMidRect(rect: CGRect, moveDistance: CGFloat, withStoreValue: CGRectStoreValue) {
        
        let midRect = rect
        let startRect = CGRect(x: rect.origin.x - moveDistance, y: rect.origin.y, width: rect.width, height: rect.height)
        let endRect = CGRect(x: rect.origin.x + moveDistance, y: rect.origin.y, width: rect.width, height: rect.height)
        
        withStoreValue.midRect   = midRect
        withStoreValue.startRect = startRect
        withStoreValue.endRect   = endRect
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
