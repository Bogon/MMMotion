//
//  WeatherView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import DeviceKit

private let cityLabelHeight: CGFloat = 120

@objc protocol WeatherViewDelegate: NSObjectProtocol {

    @objc func pullDownToRefreshData()
    @objc func pullUpEventWithData(condition: AnyObject)
}

class WeatherView: UIView {
    
    //代理
    weak var delegate: WeatherViewDelegate?
    
    //天气数据信息
    var weahterData: AllInformation? {
        didSet{
            updateInformation()
        }
    }
    
    //未来几天的天气信息
    var weatherConditions: CurrentConditions?{
        didSet{
            
        }
    }

    lazy private var tableView: UITableView = {
        let table: UITableView = UITableView(frame: self.frame, style: .plain)
        table.backgroundColor = UIColor.clear
        table.delegate = self
        table.separatorStyle = .none
        return table
    }()
    
    lazy fileprivate var weatherIconView: WeatherIconView = WeatherIconView(frame: CGRect(x: 0, y: cityLabelHeight, width: Width / 2.0, height: Width / 2.0))
    lazy fileprivate var temperatureView: TemperatureView = TemperatureView()
    lazy fileprivate var humidityView: HumidityView = HumidityView()
    lazy fileprivate var sunInfoView: SunInfoView = SunInfoView()
    lazy fileprivate var maxTempView: MaxTempView = MaxTempView()
    lazy fileprivate var windSpeedView: WindSpeedView = WindSpeedView()
    lazy fileprivate var cityTitleView: CityTitleView = CityTitleView()
    
    //上拉显示的viw
    lazy fileprivate var showDownView: ShowDownView = ShowDownView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
    //下拉显示的view
    lazy fileprivate var shapeWordView: ShapeWordView = ShapeWordView()
    
    //分割线
    lazy fileprivate var grayLine1: DividingLineView = DividingLineView(frame: CGRect(x: 0, y: cityLabelHeight - 10, width: Width, height: 0.5))
    lazy fileprivate var grayLine2: DividingLineView = DividingLineView(frame: CGRect(x: 0, y: cityLabelHeight + Width / 2.0 + Width / 2.0 + Width / 2.0, width: Width, height: 0.5))
    lazy fileprivate var grayLine3: DividingLineView = DividingLineView(frame: CGRect(x: 0, y: cityLabelHeight + Width / 2.0 + Width / 2.0 , width: Width, height: 0.5))
    lazy fileprivate var grayLine4: DividingLineView = DividingLineView(frame: CGRect(x: 0, y: cityLabelHeight + Width / 2.0  - 10, width: Width, height: 0.5))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func buildView() {
        
        //加载tableView
        self.addSubview(tableView)
        
        // 标题
        cityTitleView.frame = CGRect(x: 0, y: 0, width: Width, height: cityLabelHeight)
        cityTitleView.buildView()
        tableView.addSubview(cityTitleView)
        
        weatherIconView.buildView()
        tableView.addSubview(weatherIconView)
        
        temperatureView.frame = CGRect(x: Width / 2.0, y: cityLabelHeight, width: Width / 2.0, height: Width / 2.0)
        temperatureView.buildView()
        tableView.addSubview(temperatureView)
        
        humidityView.frame = CGRect(x: 0, y: cityLabelHeight + Width / 2.0, width: Width / 2.0, height: Width / 2.0)
        humidityView.buildView()
        tableView.addSubview(humidityView)
        

        sunInfoView.frame = CGRect(x: Width / 2.0, y: cityLabelHeight + Width / 2.0, width: Width / 2.0, height: Width / 2.0)
        sunInfoView.buildView()
        tableView.addSubview(sunInfoView)
        

        maxTempView.frame = CGRect(x: 0, y: cityLabelHeight + Width / 2.0 + Width / 2.0, width: Width / 2.0, height: Width / 2.0)
        maxTempView.buildView()
        tableView.addSubview(maxTempView)
        

        windSpeedView.frame = CGRect(x: Width / 2.0, y: cityLabelHeight + Width / 2.0 + Width / 2.0, width: Width / 2.0, height: Width / 2.0)
        windSpeedView.buildView()
        tableView.addSubview(windSpeedView)
        
        // tableView上面加载的view
        shapeWordView.frame = CGRect(x: 0, y: -20, width: Width, height: 20)
        shapeWordView.text = "Pull To Refresh"
        shapeWordView.font = UIFont(name: LATO_THIN, size: 20)
        shapeWordView.lineWidth = 0.5
        shapeWordView.lineColor = UIColor.red
        shapeWordView.buildView()
        self.tableView.addSubview(shapeWordView)
        
        // 显示进入更多天气的view的提示信息
        showDownView.center = self.center
        showDownView.frame.origin.y = Height + 20
        showDownView.layer.transform = CATransform3DConcat(showDownView.layer.transform, CATransform3DMakeRotation(CGFloat.pi, 1, 0, 0))
        tableView.addSubview(showDownView)

        
        // 添加分割线
        grayLine1.backgroundColor = UIColor.init(hexString: "#333333")
        grayLine1.alpha = 0.1
        tableView.addSubview(grayLine1)
        
        grayLine2.backgroundColor = UIColor.init(hexString: "#333333")
        grayLine2.alpha = 0.1
        tableView.addSubview(grayLine2)
        
        grayLine3.backgroundColor = UIColor.init(hexString: "#333333")
        grayLine3.alpha = 0.1
        tableView.addSubview(grayLine3)
        
        grayLine4.backgroundColor = UIColor.init(hexString: "#333333")
        grayLine4.alpha = 0.1
        tableView.addSubview(grayLine4)
    }
    
    func show() {
        guard let weatherData = weahterData else { return  }
        
        // 标题显示
        cityTitleView.cityName = weatherData.cityName
        cityTitleView.weatherDescription = weatherData.weaher[0].description //天气描述
        cityTitleView.baseStation        = weatherData.base // 基站信息
        cityTitleView.utcSec             = TimeInterval(truncating: weatherData.dt) // 更新时间
        cityTitleView.weatherNumber      = weatherData.weaher[0].weatherId
        
        // 天气图标
        weatherIconView.weatherNumber = (weatherData.weaher[0].weatherId)!
        
        // 当前温度显示(开尔文温度 --> 热力学温度)
        temperatureView.temperature = (weatherData.mainInfo.temp.intValue) - 273
        
        //湿度显示
        humidityView.percent = CGFloat(truncating: weatherData.mainInfo.humidity) / 100
        
        // 日出时间,日落时间显示
        sunInfoView.sunsireValue.utcSec = TimeInterval(weatherData.sys.sunrise)
        sunInfoView.sunsetValue.utcSec = TimeInterval(weatherData.sys.sunset)
        sunInfoView.sunsireValue.accessUtcSec()
        sunInfoView.sunsetValue.accessUtcSec()
        
        //最大温度和最小温度显示
        maxTempView.maxTemp = (weatherData.mainInfo.temp_max as! CGFloat) - 273.15
        maxTempView.minTemp = (weatherData.mainInfo.temp_min as! CGFloat) - 273.15
        
        //风速显示
        windSpeedView.windSpeed = weatherData.wind.speed as! CGFloat
        
        cityTitleView.show()
        weatherIconView.show()
        temperatureView.show()
        humidityView.show()
        sunInfoView.show()
        maxTempView.show()
        windSpeedView.show()
        
        grayLine1.show()
        grayLine2.show()
        grayLine3.show()
        grayLine4.show()

    }
    
    func hide() {
        
        // 湿度隐藏
        humidityView.hide()
        
        // 风速隐藏
        windSpeedView.hide()
        
        // 最大温度,最小温度隐藏
        maxTempView.hide()
        
        // 日出时间,日落时间显示
        sunInfoView.hide()
        
        // 当前温度
        temperatureView.hide()
        
        // 当前温度图标
        weatherIconView.hide()
        
        // 隐藏标题动画
        cityTitleView.hide()
        
        grayLine1.hide()
        grayLine2.hide()
        grayLine3.hide()
        grayLine4.hide()
      //  [self.vLine     hide];
    }
    
    
}

// MARK: - UITableView相关代理
extension WeatherView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var percent: CGFloat = (scrollView.contentOffset.y) / 60
        showDownView.showPercent(percent: percent)
        
        let offsetY: CGFloat = -scrollView.contentOffset.y
        
        if (offsetY >= 0) {
            
            percent = offsetY / 60
            self.shapeWordView.percent(percent: percent, animated: false)

        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // 位移超过60后执行动画效果
        if (scrollView.contentOffset.y >= 60) {
            guard let weatherConditions = weatherConditions, let delegate = delegate else {
                return
            }
            if delegate.responds(to: #selector(delegate.pullUpEventWithData(condition:))) {
                delegate.pullUpEventWithData(condition: weatherConditions as AnyObject)
                
                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.1, execute: { 
                    scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                })
            }
        }
        
        //向下拉行为
        if (scrollView.contentOffset.y <= -60) {

            if (delegate != nil) && delegate!.responds(to: #selector(delegate!.pullDownToRefreshData)) {
                delegate?.pullDownToRefreshData()
            }
        }

    }
}

// MARK: - 更新自定义控件内相关信息并且显示
extension WeatherView {
    fileprivate func updateInformation() {
        
        guard let weatherData = weahterData else { return  }
        
        // 标题显示
        cityTitleView.cityName = weatherData.cityName
        cityTitleView.weatherDescription = weatherData.weaher[0].description //天气描述
        cityTitleView.baseStation        = weatherData.base // 基站信息
        cityTitleView.utcSec             = weatherData.dt as! TimeInterval // 更新时间
        cityTitleView.weatherNumber      = weatherData.weaher[0].weatherId
        
         // 天气图标
        weatherIconView.weatherNumber = (weatherData.weaher[0].weatherId)!
        
        // 当前温度显示(开尔文温度 --> 热力学温度)
        temperatureView.temperature = (weatherData.mainInfo.temp.intValue) - 273
        
        //湿度显示
        humidityView.percent = CGFloat(weatherData.mainInfo.humidity) / 100
        
        // 日出时间,日落时间显示
        sunInfoView.sunsireValue.utcSec = TimeInterval(weatherData.sys.sunrise)
        sunInfoView.sunsetValue.utcSec = TimeInterval(weatherData.sys.sunset)
        sunInfoView.sunsireValue.accessUtcSec()
        sunInfoView.sunsetValue.accessUtcSec()
        
        //最大温度和最小温度显示
        maxTempView.maxTemp = (weatherData.mainInfo.temp_max as! CGFloat) - 273.15
        maxTempView.minTemp = (weatherData.mainInfo.temp_min as! CGFloat) - 273.15
        
        //风速显示
        windSpeedView.windSpeed = weatherData.wind.speed as! CGFloat
        
        cityTitleView.show()
        weatherIconView.show()
        temperatureView.show()
        humidityView.show()
        sunInfoView.show()
        maxTempView.show()
        windSpeedView.show()
        
        grayLine1.show()
        grayLine2.show()
        grayLine3.show()
        grayLine4.show()
    }
}
