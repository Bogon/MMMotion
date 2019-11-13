//
//  ForecastWeatherView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ForecastWeatherView: UIView {

    //城市编号码
    var countryCode: String?{
        didSet{
            self.countryCodeLabel.text = countryCode
            self.countryCodeLabel.sizeToFit()
        }
    }
    
    //城市名字
    var cityName: String?{
        didSet{
            self.cityNameLabel.text = cityName
            self.cityNameLabel.sizeToFit()
        }
    }
    
    lazy private var countryCodeBackgroundView = UIView()
    lazy private var countryCodeLabel = UILabel()
    lazy private var forecastLabel = UILabel()
    lazy private var cityNameLabel = UILabel()

    private var lineBackgroundView: LineBackgroundView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        self.initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews(){
        lineBackgroundView = LineBackgroundView.createViewWithFrame(frame: self.bounds, lineWidth: 4, lineGap: 4, lineColor: UIColor.black.withAlphaComponent(0.015))
        self.addSubview(lineBackgroundView!)
        
    }
    
    //创建出view
    func buildView() {
        countryCodeBackgroundView.frame = CGRect(x: 15, y: 15, width: 37, height: 22)
        countryCodeBackgroundView.backgroundColor = UIColor.red
        self.addSubview(countryCodeBackgroundView)
        
        countryCodeLabel.frame = countryCodeBackgroundView.bounds
        countryCodeLabel.textAlignment = .center
        countryCodeLabel.text = ""
        countryCodeLabel.font = UIFont(name: LATO_LIGHT, size: LATO_14)
        countryCodeLabel.textColor = UIColor.white
        self.countryCodeBackgroundView.addSubview(countryCodeLabel)
        
        forecastLabel.frame = CGRect(x: countryCodeBackgroundView.frame.origin.x + 50, y: countryCodeBackgroundView.frame.origin.y, width: 0, height: 0)
        forecastLabel.text      = "Weather Forecast"
        forecastLabel.font      = UIFont(name: LATO_LIGHT, size: LATO_16)
        forecastLabel.textColor = UIColor.black
        forecastLabel.sizeToFit()
        self.addSubview(forecastLabel)
            
        cityNameLabel.frame      = CGRect(x: self.countryCodeBackgroundView.frame.origin.x, y: countryCodeBackgroundView.frame.origin.x + 30, width: 0, height: 0)
        cityNameLabel.text = ""
        cityNameLabel.font = UIFont(name: LATO_LIGHT, size: 47)
 
        cityNameLabel.sizeToFit()
        self.addSubview(cityNameLabel)

    }
    
    func show() {
        
    }
    func hide() {
        
    }
    

}
