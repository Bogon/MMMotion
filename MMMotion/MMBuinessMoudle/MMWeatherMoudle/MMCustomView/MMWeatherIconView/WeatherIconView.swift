//
//  WeatherIconView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class WeatherIconView: UIView {

    //天气文本
    var weatherNumber: Int = 0
    private var storeValue: CGRectStoreValue = CGRectStoreValue()
    
    lazy var titleMoveLabel: TitleMoveLabel = TitleMoveLabel.withText(text: "Weather")
    
//    lazy var glowLabel: UILabel = {
//        let lable = UILabel(frame: self.bounds)
//        lable.textAlignment = .center
//        return lable
//    }()
    lazy var glowLabel: GlowLabel = GlowLabel()
    
    var stoteValue: CGRectStoreValue = CGRectStoreValue()
    
    //创建view
    func buildView() {
        self.addSubview(titleMoveLabel)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //显示
    func show() {
        
        titleMoveLabel.show()
        
        glowLabel.frame = self.bounds
        glowLabel.textAlignment = .center
        glowLabel.font = UIFont(name: WEATHER_TIME, size: 110)
        
        stoteValue.midRect        = glowLabel.frame
        glowLabel.frame.origin.y -= 10
        stoteValue.startRect      = glowLabel.frame
        glowLabel.frame.origin.y += 20;
        stoteValue.endRect        = glowLabel.frame
        glowLabel.frame           = stoteValue.startRect
        
        glowLabel.gcdTimerInterval = 1.75
        glowLabel.glowLayerOpacity = 1.5
        glowLabel.glowDuration = 1
        glowLabel.alpha = 1.0
        glowLabel.text = WeatherNumberMeaningTransform.fontTextWeatherNumber(number: self.weatherNumber)
        glowLabel.createGlowLayerWithColor(color: WeatherNumberMeaningTransform.iconColor(number: weatherNumber), glowRadius: 2)
 
        glowLabel.startGlow()
        glowLabel.alpha         = 0.0
        
        self.addSubview(self.glowLabel)
        
        UIView.animate(withDuration: 1.75) { 
            self.glowLabel.alpha = 1.0
            self.glowLabel.frame = self.stoteValue.midRect
        }
        
    }
    
    //隐藏
    func hide() {
        
        self.titleMoveLabel.hide()
        
        UIView.animate(withDuration: 0.75, animations: { 
            self.glowLabel.alpha = 0.0
            self.glowLabel.frame = self.stoteValue.endRect
            
        }) { (_) in
            
            self.glowLabel.frame = self.stoteValue.startRect
            self.glowLabel.removeFromSuperview()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
