//
//  MMNewsController+Layout.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import DeviceKit
import Hue

/// 控制器：全局退出(退出类型)
enum XNControllerFadeType: Int {
    case pop        = 1     /// 支持手势优化退出
    case dismiss    = 2     /// Present的控制器退出
}

extension MMNewsController {
    
    /// 初始化UI
    override func loadView() {
        super.loadView()
        /// 搭建首页界面
        self.initlizeSubViews()
        self.title = "体育时事新闻"
        self.initNavigationStyle()
    }
    
    func initlizeSubViews() {
         self.view.backgroundColor = UIColor.init(hex: "#f5f6f8")
        
        var contentViewHeight: CGFloat = UIScreen.ol_height - 64
        let device = Device.current
        if device.isOneOf([.iPhoneXS, .iPhoneX, .iPhoneXR, .iPhoneXSMax, .iPhone11, .iPhone11Pro, .iPhone11ProMax]) {
            contentViewHeight = UIScreen.ol_height - 88
        } else if device.isOneOf([.simulator(.iPhoneXS), .simulator(.iPhoneX), .simulator(.iPhoneXR), .simulator(.iPhoneXSMax), .simulator(.iPhone11), .simulator(.iPhone11Pro), .simulator(.iPhone11ProMax)]) {
            contentViewHeight = UIScreen.ol_height - 88
        }
        /// 设置contentTableView
        self.contentTableView = MMContentViewHandler.shared.getContentTableView(self)
        self.contentTableView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.ol_width , height: contentViewHeight)
        self.contentTableView.backgroundColor = UIColor.clear
        self.contentTableView.tableHeaderView = UIView()
        self.contentTableView.separatorStyle = .none
        self.contentTableView.tableFooterView = UIView()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        
        self.view.addSubview(self.contentTableView)
        
        /// 
        self.contentTableView.xn_registerCellNib(MMSportsNewsViewCell.self)
        
    }
    
    /// 设置导航栏风格
    func initNavigationStyle() {
        
        /// 标题颜色
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#333333"),NSAttributedString.Key.font : UIFont
            .boldSystemFont(ofSize: 18)]
        navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        
        /// 设置导航栏
        navigationController?.navigationBar.setBackgroundImage(UIImage.getImage(WithColor: UIColor.init(hex: "#FFFFFF")), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.initLeftItem(.pop)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
    }
    
    func initLeftItem(_ type: XNControllerFadeType) {
        let spaceItem: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        spaceItem.width = -6
        if #available(iOS 11.0, *) {
            spaceItem.width = -20
        }
        switch type {
        case .pop:  // R.image.barbutton_back()
            let closeItem:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "barbutton_back"), style: .plain, target: self, action:
                #selector(pop))
            closeItem.tintColor = .black
            navigationItem.leftBarButtonItem = closeItem
        case .dismiss:  // R.image.dismiss_icon()
            let closeItem:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "barbutton_back"), style: .plain, target: self, action:
                #selector(dismissController))
            closeItem.tintColor = .black
            navigationItem.leftBarButtonItem = closeItem
            
        }
    }
    
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
