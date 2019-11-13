//
//  XNUnionController.swift
//  perpetualCalendar
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

import UIKit
import DeviceKit

@objc class cowCloudUnionController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate {
    
    deinit {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
    }
    
    /**
     On disappear calls `stopFollowingScrollView()` to stop observing the current scroll view, and perform the tear down
     */
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    
    /**
     Calls `showNavbar()` when a `scrollToTop` is requested
     */
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
        return true
    }

    
    public override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.isTranslucent = false

        /// 设置导航栏背景颜色
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font : UIFont
            .boldSystemFont(ofSize: 18)]
        /// 标题颜色
        navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        navigationController?.navigationBar.barTintColor = UIColor.clear
        /// 修改返回按钮的颜色
        navigationController?.navigationBar.tintColor = .white
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hex: "#f5f6f8")
        
        var contentViewHeight: CGFloat =  64
        let device = Device.current
        if device.isOneOf([.iPhoneXS, .iPhoneX, .iPhoneXR, .iPhoneXSMax, .iPhone11, .iPhone11Pro, .iPhone11ProMax]) {
            contentViewHeight = 88
        } else if device.isOneOf([.simulator(.iPhoneXS), .simulator(.iPhoneX), .simulator(.iPhoneXR), .simulator(.iPhoneXSMax), .simulator(.iPhone11), .simulator(.iPhone11Pro), .simulator(.iPhone11ProMax)]) {
            contentViewHeight = 88
        }
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(color: .white, size: CGSize.init(width: UIScreen.ol_width, height: contentViewHeight)), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
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
    
    @objc func pop() {
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

