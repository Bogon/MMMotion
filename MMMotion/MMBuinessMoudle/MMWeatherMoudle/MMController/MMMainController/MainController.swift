//
//  ViewController.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import CoreLocation
import TWMessageBarManager
import SnapKit
import RxSwift

class MainController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    lazy fileprivate var weatherView: WeatherView = WeatherView(frame: UIScreen.main.bounds)
    lazy fileprivate var upDatingView: UpdatingView = UpdatingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2.0, height: UIScreen.main.bounds.width / 2.0 + 20.0))
    lazy fileprivate var fadeBlackView: FadeBlackView = FadeBlackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    //失败的view
    lazy fileprivate var failedView: FailedLongPressView = FailedLongPressView()
    
    var locataMan: MapManager?
    
    /// 返回按钮
    lazy var backButton:UIButton = {
        
        let dateImage:UIButton = UIButton()
        dateImage.setImage(UIImage.init(named: "clipBack"), for: .normal)
        return dateImage
        
    }()
    
    var timer: DispatchSourceTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
               
        //天气的view
        weatherView.layer.masksToBounds = true
        weatherView.buildView()
        weatherView.delegate = self
        self.view.addSubview(self.weatherView)
        
        // 变黑
        self.view.addSubview(fadeBlackView)
        
       // loading
        upDatingView.center = self.view.center
        self.view.addSubview(upDatingView)
        
        //定位功能
        MapManager.shared.delegate = self

        // 加载失败后显示的view
        failedView.frame = self.view.bounds
        failedView.delegate = self
        failedView.buildView()
        self.view.addSubview(failedView)
        
        // 进入加载数据动画效果
        getLocationAndFadeShow()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.backButton)
        self.backButton.snp.remakeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-12)
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            make.size.equalTo(CGSize.init(width: 44, height: 55))
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        self.backButton.rx.tap.subscribe(onNext:{ [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
       
    //得到位置和fadeshow
    fileprivate func getLocationAndFadeShow() {
        //显示等待页面
        fadeBlackView.show()
        upDatingView.show()
        
        //开始定位
        MapManager.shared.start()
   
    }
    
    private func getCityIdAndFadeShow() {
        //显示等待页面
        fadeBlackView.show()
        upDatingView.show()
        
        //开始定位
        MapManager.shared.start()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - WeatherView相关代理
extension MainController: WeatherViewDelegate {
    //上拉进入新的控制器
    func pullUpEventWithData(condition: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
            let forecastCV = ForecastController()
            forecastCV.transitioningDelegate  = self
            forecastCV.modalTransitionStyle = .coverVertical
            forecastCV.modalPresentationStyle = .custom
            forecastCV.weatherCondition = condition as? CurrentConditions
            self.present(forecastCV, animated: true, completion: nil)
        }
        
    }
    
    //下拉更新数据
    func pullDownToRefreshData() {
        MapManager.shared.locationFlag = true
        getLocationAndFadeShow()
      
    }
}

// MARK: - MapManager相关代理
extension MainController: MapManagerLocationDelegate{
    
    func mapDidUpdateAndGetLastCLLocation(manager: MapManager, location: CLLocation) {
        print("定位成功 - 并开始获取网路数据")
        
        //取消先前向performSelector注册的执行请求：withObject：afterDelay：instance方法。
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(delayRunEvent(location:)), with: location, afterDelay: 0.3)
    }
    
    func mapDidFailed(manager: MapManager, error: Error) {
        print("定位失败")
        self.upDatingView.showFailed()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) { 
            self.fadeBlackView.hide()
            self.upDatingView.hide()
            self.failedView.show()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            
            TWMessageBarManager.sharedInstance().showMessage(withTitle: "Failed to locate", description: "Sorry, temporarily unable to locate your position.", type: .error, callback: nil)
            
        }
    }
    
    func mapManagerServerClosed(manager: MapManager) {
        DispatchQueue.main.async {
            
            TWMessageBarManager.sharedInstance().showMessage(withTitle: "Failed to locate", description: "Please turn on your Location Service.", type: .error, callback: nil)

        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) { 
            self.fadeBlackView.hide()
            self.upDatingView.hide()
            self.failedView.show()
            
        }
    }
    
    /// 延迟执行
    ///
    /// - Parameter location: 过滤掉干扰项目
    @objc private func delayRunEvent(location: CLLocation) {
        
        //获取网络数据
        
        weatherView.hide()
        WeatherInfoDAL.getAllInformation(lat: CGFloat(location.coordinate.latitude), lon: CGFloat(location.coordinate.longitude)) { (allInformation, isSusseed) in
            
            if isSusseed {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                    
                    self.fadeBlackView.hide()
                    self.upDatingView.hide()
                    self.failedView.hide()
    
                    
                    
                    WeatherInfoDAL.getCurrentConditions(lat: CGFloat(location.coordinate.latitude), lon: CGFloat(location.coordinate.longitude), completion: { (currentConditions, isSucceed) in
                        
                        if isSusseed {
                            
                            self.failedView.remove()
                            self.weatherView.weahterData = allInformation
                            self.weatherView.weatherConditions = currentConditions
                            
                        }else {
                            
                            self.failedView.show()
                            
                        }
                        
                    })
                    
                })

            }else {
                
                self.fadeBlackView.hide()
                self.upDatingView.hide()
                self.failedView.show()
                
            }
            
        }
    }
}

// MARK: - FailedLongPressViewDelegate相关代理方法
extension MainController: FailedLongPressViewDelegate {
    
    func pressEvent(view: FailedLongPressView) {
        
        failedView.hide()
        //得到位置和fadeshow
        getLocationAndFadeShow()
    }
}

// MARK: - UIViewControllerTransitioningDelegate相关代理(转场)
extension MainController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentingAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DismissingAnimator()
    }
}




