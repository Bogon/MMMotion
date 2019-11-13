//
//  MMMacro.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation

/// 首页模块通知
extension Notification.Name {
    // 进入AI助手界面
    public static let gotoAI: Notification.Name = Notification.Name("gotoAI")
    // 查看天气反馈
    public static let seeWeatherInfo: Notification.Name = Notification.Name("seeWeatherInfo")
    // 手机所在地查询
    public static let phonenumberlocation: Notification.Name = Notification.Name("phonenumberlocation")
    // 火星文转换
    public static let huoXingWenTranfor: Notification.Name = Notification.Name("huoXingWenTranfor")
}
