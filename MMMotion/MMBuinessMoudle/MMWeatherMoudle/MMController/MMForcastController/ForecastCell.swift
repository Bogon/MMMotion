//
//  ForecastCell.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    lazy private var weekDayInfoLabel = UILabel()
    lazy private var dateLabel = UILabel()
    lazy private var minTempLabel = UILabel()
    lazy private var maxTempLabel = UILabel()
    //用于显示天气图标
    lazy private var weatherLabel = UILabel()
    //用于显示天气描述
    lazy private var weatherInfoLabel = UILabel()


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        // 初始化标签
        initLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func initLabels() {
        // 星期几
        weekDayInfoLabel.frame         = CGRect(x: 17 + 10, y: 24, width: 100, height: 60)
        weekDayInfoLabel.textAlignment = .left
        weekDayInfoLabel.font          = UIFont(name: LATO_THIN, size: 40)
        weekDayInfoLabel.text          = "Today"
            
        weekDayInfoLabel.sizeToFit()
        self.addSubview(weekDayInfoLabel)
        
        // 日期
        dateLabel.frame         = CGRect(x: 0, y: 0, width: 50, height: 12)
        dateLabel.textAlignment = .center
        dateLabel.font          = UIFont(name: LATO_REGULAR, size: 8)
        dateLabel.text          = "2015.2.25"
        dateLabel.textColor     = UIColor.white
        
        let dateBlackView = UIView(frame: CGRect(x: Width - 50, y: 0, width: 50, height: 12))
        dateBlackView.backgroundColor = UIColor.black.withAlphaComponent(0.95)
        dateBlackView.addSubview(dateLabel)
        
        // 最低温度
        minTempLabel.frame         = CGRect(x: 120, y: 25, width: 200, height: 70)
        minTempLabel.textAlignment = .left
        minTempLabel.font          = UIFont(name: LATO_THIN, size: 40)
        minTempLabel.text          = "-200.0°"
        
        minTempLabel.sizeToFit()
        self.addSubview(minTempLabel)
        
        // 最高温度
        maxTempLabel.frame         = CGRect(x: 100 + 80 + 40, y: 25, width: 200, height: 70)
        maxTempLabel.textAlignment = .left
        maxTempLabel.font          = UIFont(name: LATO_THIN, size: 40)
        maxTempLabel.text          = "-200.0°"
        
        maxTempLabel.sizeToFit()
        self.addSubview(maxTempLabel)
        
        // 天气图标
        weatherLabel.frame         = CGRect(x: 250 + 70, y: 24, width: 60, height: 60)
        weatherLabel.textAlignment = .center
        weatherLabel.font          = UIFont(name: WEATHER_TIME, size: 50)
        
        self.addSubview(weatherLabel)
        
        // 天气描述信息
        weatherInfoLabel.frame         = CGRect(x: 5, y: 0, width: 300, height: 12)
        weatherInfoLabel.textAlignment = .left
        weatherInfoLabel.font          = UIFont(name: LATO_REGULAR, size: 10)
        self.addSubview(weatherInfoLabel)
        
        // 线条
        let line = UIView(frame: CGRect(x: 0, y: Width / 4 - 0.5, width: Width, height: 0.5))
        line.backgroundColor = UIColor.black
        line.alpha           = 0.1
        self.addSubview(line)

    }
    
    //处理常规数据
    func acccessData(weatherInfo: WeatherInfo, indexPath: IndexPath) {
        
        // 最高温度
        let maxTemp = "\(Int(weatherInfo.temp.max.floatValue - 273.15))" + "°"
        maxTempLabel.text = maxTemp
        
        // 最低温度
        let minTemp = "\(Int(weatherInfo.temp.min.floatValue - 273.15))" + "°"
        minTempLabel.text = minTemp
        
        let utcDate = Date(timeIntervalSince1970: TimeInterval(weatherInfo.dt))
        let formatter = DateFormatter()
        
        
        // 更新图标
        let weather = weatherInfo.weather[0]
        weatherLabel.text = WeatherNumberMeaningTransform.fontTextWeatherNumber(number: weather.weatherId)
        
        // 天气描述信息
        weatherInfoLabel.text = weather.description
        
        // 年份
        formatter.dateFormat = "yyyy.MM.dd"
        let yearStr = formatter.string(from: utcDate)
        dateLabel.text = yearStr
        
        // 星期几
        formatter.dateFormat = "EEEE"
        formatter.weekdaySymbols = ["Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat"]
        weekDayInfoLabel.textColor = UIColor.black
        let hourStr = formatter.string(from: utcDate)
        weekDayInfoLabel.text      = hourStr
        if hourStr == "Sun" {
            
            self.weekDayInfoLabel.textColor = UIColor.red
            
        } else {
            
            self.weekDayInfoLabel.textColor = UIColor.black
        }
        
    }
    
    func show() {
        UIView.animate(withDuration: 0.5) { 
            self.weekDayInfoLabel.frame.origin.x = 17
        }
    }
    
    func hide() {
        self.weekDayInfoLabel.frame.origin.x = 17 + 10
    }

}
