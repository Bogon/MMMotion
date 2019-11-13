//
//  MMMainController.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit
import DeviceKit
import RxCocoa
import RxSwift

class MMMainController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    let disposeBag = DisposeBag()
    
    /// 资讯详情页
    lazy var nextButton: UIButton = {
        let nextButton: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 55, height: 55))
        nextButton.setImage(UIImage.init(named: "next"), for: .normal)
        return nextButton
    }()
    
    var historyInTodayInfoModel: MMHistoryInTodayInfoModel?
    
    /// 主要的界面滑动视图
    lazy var scrollView: UIScrollView! = MMScrollViewHandler.shared.getScrollView()
    /// 内容视图
    lazy var contentView: UIView! = MMContentViewHandler.shared.getContentView()
    
    /// 显示历史上的今日
    var historyInTodayView: MMHistoryInTodayView = MMHistoryInTodayView.instance()!
    
    /// AI助手
    var lifeAssistantView: MMLifeAssistantView = MMLifeAssistantView.instance()!
    /// 天气详情
    var weatherInfoView: MMWeatherInfoView = MMWeatherInfoView.instance()!
    /// 手机号码所在地查询
    var phoneNumberLocationView: MMPhoneNumberLocationView = MMPhoneNumberLocationView.instance()!
    /// 火星文转换
    var huoXingWenView: MMHuoXingWenView = MMHuoXingWenView.instance()!
    
    /// 设置导航栏效果
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerObserver()
        self.registerNotificationCenter()
        
        weak var weakSelf = self
        /// 添加更多城市时间
        self.nextButton.rx.tap
            .subscribe(onNext:{
                guard let strongSelf = weakSelf else { return }
               /// TODO……
               strongSelf.navigationController?.pushViewController(MMNewsController())
            }).disposed(by: disposeBag)
               
        
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(scrollView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(scrollView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
        
        
    }
    
    func scrollingNavigationController(_ controller: ScrollingNavigationController, didChangeState state: NavigationBarState) {
        switch state {
        case .collapsed:
            print("navbar collapsed")
        case .expanded:
            print("navbar expanded")
        case .scrolling:
            print("navbar is moving")
        }
    }

}
