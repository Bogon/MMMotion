//
//  MMMainController+Notification.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import UIKit

extension MMMainController {

    /*************************| 主页天气模块 |************************/
    /// 注册通知中心
    func registerNotificationCenter() {
        weak var weakSelf = self
        /// ai聊天
        NotificationCenter.default.rx
            .notification(NSNotification.Name.gotoAI)
            .takeUntil(self.rx.deallocated)         /// 页面销毁自动移除通知监听
            .subscribe(onNext: { notification in
                guard let strongSelf = weakSelf else { return }
                strongSelf.gotoAIAssistant()
        }).disposed(by: disposeBag)
        
        /// 查看天气
        NotificationCenter.default.rx
            .notification(NSNotification.Name.seeWeatherInfo)
            .takeUntil(self.rx.deallocated)         /// 页面销毁自动移除通知监听
            .subscribe(onNext: { notification in
                guard let strongSelf = weakSelf else { return }
                strongSelf.gotoWeatherInfo()
        }).disposed(by: disposeBag)
        
        /// 手机定位
        NotificationCenter.default.rx
            .notification(NSNotification.Name.phonenumberlocation)
            .takeUntil(self.rx.deallocated)         /// 页面销毁自动移除通知监听
            .subscribe(onNext: { notification in
                guard let strongSelf = weakSelf else { return }
                strongSelf.findPhoneNumberLocation()
        }).disposed(by: disposeBag)
        
        /// 火星文转换
        NotificationCenter.default.rx
            .notification(NSNotification.Name.huoXingWenTranfor)
            .takeUntil(self.rx.deallocated)         /// 页面销毁自动移除通知监听
            .subscribe(onNext: { notification in
                guard let strongSelf = weakSelf else { return }
                strongSelf.huoXingWenTranfer()
        }).disposed(by: disposeBag)
    }
    
    /// 火星文转换 
    func huoXingWenTranfer() {
        var inputText: String = ""
        let alert = UIAlertController(style: .alert, title: "火星文转换", message: "请输入你想要转换的中文字句")
        weak var weakSelf = self

        let textField: TextField.Config = { textField in
            textField.left(image: #imageLiteral(resourceName: "input"), color: .black)
            textField.leftViewPadding = 12
            textField.becomeFirstResponder()
            textField.borderWidth = 1
            textField.cornerRadius = 8
            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
            textField.backgroundColor = nil
            textField.textColor = .black
            textField.placeholder = "请输入…"
            textField.keyboardAppearance = .default
            textField.keyboardType = .default
            textField.returnKeyType = .done
            textField.action {  textField in
                Log("textField = \(String(describing: textField.text))")
                inputText = textField.text ?? ""
            }
        }
        
        alert.addOneTextField(configuration: textField)
        alert.addAction(title: "转换", style: UIAlertAction.Style.cancel, isEnabled: true) { (alert) in
            Log("textField = \(inputText)")
            guard let strongSelf = weakSelf else { return }
            strongSelf.textTransfer(WithText: inputText)
        }
        alert.show()
    }
    
    /// 转换成火星文
    func textTransfer(WithText vlaue: String) {
        
        /// 未输入信息不弹窗
        if vlaue.ol_length == 0 {
            return
        }
        
        weak var weakSelf = self
        MBProgressHUD.showMessage("正在转换……", to: self.view)
        MMHuoXingWenTransferAPIViewModel.shared.getHuoXingWenTransfer(WithCache: false, text: vlaue).done { (response) in
                guard let strongSelf = weakSelf else { return }
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                
                /// 提示信息
            let alert = UIAlertController(style: .alert, title: "转换结果", message: "\(response.result ?? "-")")   //addAction(title: "拷贝", style: .default)
            alert.addAction(title: "拷贝", style: .default, isEnabled: true) { (action) in
                    let pas = UIPasteboard.general
                    pas.string = "\(response.result ?? "-")"
            }
            alert.show()
        }.catch { (error) in
            guard let strongSelf = weakSelf else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            MBProgressHUD.showError("转换失败，请重试！", to: self.view)
        }
        
    }
    
    /// 查询手机号码所在地
    func findPhoneNumberLocation() {
        var phoneNumber: String = ""
        let alert = UIAlertController(style: .alert, title: "查询手机号码所在地", message: "请输入手机号码")
        weak var weakSelf = self

        let textField: TextField.Config = { textField in
            textField.left(image: #imageLiteral(resourceName: "pen"), color: .black)
            textField.leftViewPadding = 12
            textField.becomeFirstResponder()
            textField.borderWidth = 1
            textField.cornerRadius = 8
            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
            textField.backgroundColor = nil
            textField.textColor = .black
            textField.placeholder = "手机号码前7位"
            textField.keyboardAppearance = .default
            textField.keyboardType = .numberPad
            textField.returnKeyType = .done
            textField.action {  textField in
                Log("textField = \(String(describing: textField.text))")
                phoneNumber = textField.text ?? ""
            }
        }
        
        alert.addOneTextField(configuration: textField)
        alert.addAction(title: "查询", style: UIAlertAction.Style.cancel, isEnabled: true) { (alert) in
            Log("textField = \(phoneNumber)")
            guard let strongSelf = weakSelf else { return }
            strongSelf.findResult(WithNumber: phoneNumber)
        }
        alert.show()
    }
    
    /// 查询手机号码
    func findResult(WithNumber vlaue: String) {
        
        /// 未输入信息不弹窗
        if vlaue.ol_length == 0 {
            return
        }
        
        /// 少于七个进行弹窗
        if vlaue.ol_length < 7 {
            MBProgressHUD.showError("至少输入前7位手机号码！", to: self.view)
            return
        }
        
        weak var weakSelf = self
        MBProgressHUD.showMessage("正在查询……", to: self.view)
        MMMobileLocationAPIViewModel.shared.getMobileInfo(WithCache: false, mobile: vlaue).done { (respose) in
            guard let strongSelf = weakSelf else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            
            /// 提示信息
            let alert = UIAlertController(style: .alert, title: "查询结果", message: "手机号码：\(vlaue) \n所在地：\(respose.result?.province ?? "-")-\(respose.result?.city ?? "-") \n运营商：\(respose.result?.company ?? "-")")
            alert.addAction(title: "好的", style: .default)
            alert.show()
            
        }.catch { (error) in
            guard let strongSelf = weakSelf else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            MBProgressHUD.showError("查询失败，请重试！", to: self.view)
        }
        
    }
    
    /// 前去AI机器人
    func gotoAIAssistant() {
        self.navigationController?.pushViewController(MMMessageMainController(), animated: true)
    }
        
    /// 查看天气
    func gotoWeatherInfo() {
        let weatherController = MainController()
        weatherController.modalPresentationStyle = .overFullScreen
        self.present(weatherController, animated: true, completion: nil)
    }
    
}
