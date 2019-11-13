//
//  UIImage+Compress.swift
//  weather
//
//  Created by jiangqi on 2019/4/16.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

import Foundation
import DeviceKit

extension UIImage {

    /// 获取导航栏对应颜色图片
    static func getImage(WithColor color: UIColor) -> UIImage {
        /// 设置产生导航栏顶部图片
        var bgImageHeight: CGFloat = 64
        let device: Device = Device.current
        if device.isOneOf([Device.iPhoneX, Device.iPhoneXR, Device.iPhoneXS, Device.iPhoneXSMax, Device.iPhone11, Device.iPhone11Pro, Device.iPhone11ProMax]) {
             bgImageHeight = 88
        } else if device.isOneOf([Device.simulator(Device.iPhoneX),Device.simulator(Device.iPhoneXR),Device.simulator(Device.iPhoneXR),Device.simulator(Device.iPhoneXSMax),Device.simulator(Device.iPhone11),Device.simulator(Device.iPhone11Pro),Device.simulator(Device.iPhone11ProMax)]){
             bgImageHeight = 88
        }
        
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.ol_width, height: bgImageHeight)
        // 开启位图上下文
        UIGraphicsBeginImageContext(rect.size)
        // 获取位图上下文
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // 使用color演示填充上下文
        context.setFillColor(color.cgColor)
        // 渲染上下文
        context.fill(rect)
        // 从上下文中获取图片
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // 结束上下文
        UIGraphicsEndImageContext()
        
        return image
    }
}


import UIKit

//--- UIImageTintExtension.swift ---
extension UIImage {
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        //Make(0.0, 0.0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        //let context = UIGraphicsGetCurrentContext()
        //CGContextClipToMask(context, drawRect, CGImage)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
