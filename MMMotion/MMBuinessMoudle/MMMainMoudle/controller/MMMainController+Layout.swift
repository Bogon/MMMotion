//
//  MMMainController+Layout.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import DeviceKit
import Hue

extension MMMainController {
    
    /// 初始化UI
    override func loadView() {
        super.loadView()
        /// 搭建首页界面
        self.initlizeSubViews()
        self.title = "运动E口袋"
        self.initNavigationStyle()
    }
    
    func initlizeSubViews() {
        self.view.backgroundColor = UIColor.init(hex: "#EF2971")
        
        var scrollTopMargin: CGFloat = 80
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax]) {
             scrollTopMargin = 120
        } else if device.isOneOf([Device.simulator(Device.iPhoneX),Device.simulator(Device.iPhoneXR),Device.simulator(Device.iPhoneXR),Device.simulator(Device.iPhoneXSMax),Device.simulator(Device.iPhone11),Device.simulator(Device.iPhone11Pro),Device.simulator(Device.iPhone11ProMax)]){
             scrollTopMargin = 120
        }
        
        // Make our ScrollView
        let frame: CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.ol_width, height: UIScreen.ol_height)
        self.scrollView.frame = frame
        self.view.addSubview(self.scrollView)
        
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        
        
        self.contentView.backgroundColor = UIColor.white
        self.contentView.frame = CGRect.init(x: 0, y: scrollTopMargin, width: UIScreen.ol_width, height: UIScreen.ol_height)
        self.contentView.layer.masksToBounds = true
        self.contentView.corner(byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], radii: 30)
        self.scrollView.addSubview(self.contentView)
        
        /// 历史今日
        self.scrollView.addSubview(self.historyInTodayView)
        
        /// AI助手
        self.scrollView.addSubview(self.lifeAssistantView)
        /// 天气详情
        self.scrollView.addSubview(self.weatherInfoView)
        /// 手机号码所在地查询
        self.scrollView.addSubview(self.phoneNumberLocationView)
        /// 火星文转换
        self.scrollView.addSubview(self.huoXingWenView)
        
        /// 添加资讯页面
        self.scrollView.addSubview(self.nextButton)
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: UIScreen.ol_height + 15)
        
        MMHistoryInTodayAPIViewModel.shared.getTalkingInfo(WithCache: true).done { [weak self] (response) in
            self?.historyInTodayInfoModel = response.result?.first
            self?.historyInTodayView.setContent((self?.historyInTodayInfoModel!)!)
            self?.view.setNeedsLayout()
        }.catch { [weak self] (error) in
            self?.historyInTodayInfoModel = MMHistoryInTodayInfoModel()
            self?.historyInTodayView.setContent((self?.historyInTodayInfoModel!)!)
            self?.view.setNeedsLayout()
        }
        
        
    }
    
    /// 设置导航栏风格
    func initNavigationStyle() {
        
        /// 标题颜色
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#FFFFFF"),NSAttributedString.Key.font : UIFont
            .boldSystemFont(ofSize: 18)]
        navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        
        /// 设置导航栏
        navigationController?.navigationBar.setBackgroundImage(UIImage.getImage(WithColor: UIColor.init(hex: "#EF2971")), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.lifeAssistantView.snp.remakeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.top.equalTo(self.contentView.snp.top).offset(80)
            make.size.equalTo(MMLifeAssistantView.layoutSize())
        }
        
        self.weatherInfoView.snp.remakeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentView.snp.top).offset(80)
            make.size.equalTo(MMWeatherInfoView.layoutSize())
        }
        
        self.phoneNumberLocationView.snp.remakeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.top.equalTo(self.lifeAssistantView.snp.bottom).offset(15)
            make.size.equalTo(MMPhoneNumberLocationView.layoutSize())
        }
        
        self.huoXingWenView.snp.remakeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.lifeAssistantView.snp.bottom).offset(15)
            make.size.equalTo(MMHuoXingWenView.layoutSize())
        }
        
        self.nextButton.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.top.equalTo(self.huoXingWenView.snp.bottom).offset(30)
            make.size.equalTo(CGSize.init(width: 55, height: 55))
        }
        
        guard let valueModel = self.historyInTodayInfoModel else {
            
            self.historyInTodayView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.contentView.snp.centerX)
                make.bottom.equalTo(self.contentView.snp.top).offset(50)
                make.size.equalTo(CGSize.init(width: UIScreen.ol_width - 30, height: MMHistoryInTodayView.layoutHeight(WithModel: MMHistoryInTodayInfoModel())))
            }   
            
            return
        }
        
        self.historyInTodayView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.bottom.equalTo(self.contentView.snp.top).offset(50)
            make.size.equalTo(CGSize.init(width: UIScreen.ol_width - 30, height: MMHistoryInTodayView.layoutHeight(WithModel: valueModel)))
        }
    }
    
}
