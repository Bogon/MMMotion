//
//  ForecastController.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ForecastController: UIViewController {

    lazy private var tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    fileprivate var cellHeight: CGFloat = 0
    fileprivate var  weatherDataArray: [Any]?
    
    //下拉显示的view
    lazy fileprivate var showDownView: ShowDownView = ShowDownView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
    lazy private var forecastView: ForecastWeatherView = ForecastWeatherView()
    
    //天气预报
    var weatherCondition: CurrentConditions? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        initTableView()
        
        // 加载动画并动画显示
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
   
            self.weatherDataArray = self.weatherCondition?.list
            var indexPathArray: [IndexPath] = []
            for count in 0..<self.weatherDataArray!.count {
                let path = IndexPath(row: count, section: 0)
                indexPathArray.append(path)
            }
            self.tableView.insertRows(at: indexPathArray, with: .fade)
        }

        // 显示进入更多天气的view的提示信息
        showDownView.center = self.view.center
        showDownView.frame.origin.y = -30
        tableView.addSubview(showDownView)
        
    }
    
    private func initTableView() {
        // cell高度
        self.cellHeight           = Width / 4
        self.tableView.delegate   = self
        self.tableView.dataSource = self
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator   = false
        self.tableView.separatorStyle                 = .none
        self.tableView.register(ForecastCell.classForCoder(), forCellReuseIdentifier: "ForecastCell")
        self.view.addSubview(tableView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//MARK: - tableView相关代理
extension ForecastController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ForecastCell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        cell.acccessData(weatherInfo: self.weatherDataArray?[indexPath.row] as! WeatherInfo, indexPath: indexPath)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y <= -60) {
            
            UIView.animate(withDuration: 0.5, animations: {
                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
            })
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15, execute: {
                self.dismiss(animated: true, completion: nil)
            })
            
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percent = (-scrollView.contentOffset.y) / 60
        showDownView.showPercent(percent: percent)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let forecastCell = cell as! ForecastCell
        forecastCell.show()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let forecastCell = cell as! ForecastCell
        forecastCell.hide()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //设置table的header
        if (section == 0) {
            let titleView: ForecastWeatherView = ForecastWeatherView(frame: CGRect(x: 0, y: 0, width: Width, height: 160))
            titleView.buildView()
            
            titleView.cityName = self.weatherCondition?.city.cityName ?? "未找到"
            titleView.countryCode = self.weatherCondition?.city.country ?? "未找到"
            
            let line = UIView(frame: CGRect(x: 0, y: 160 - 1, width: Width, height: 0.5))
            line.backgroundColor = UIColor.black
            line.alpha           = 0.1
            titleView.addSubview(line)
            return titleView;
            
        } else {
            
            return nil;
        }
    }

    //header的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 160
    }
    
}
