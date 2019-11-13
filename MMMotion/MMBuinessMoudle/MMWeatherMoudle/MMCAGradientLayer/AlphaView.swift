//
//  AlphaView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/18.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class AlphaView: UIView {

    var colors:[CGColor]?{
        didSet{
            //将color转成cgColor
            
            gradientLayer.colors = colors
        }
    }
    var locations:[(NSNumber)]?{
        didSet{
            gradientLayer.locations = locations
        }
    }
    
    
    var startPoint: CGPoint?{
        didSet{
            gradientLayer.startPoint = startPoint!
        }
    }
    
    var endPoint: CGPoint?{
        didSet{
            gradientLayer.endPoint = endPoint!
        }
    }

    /*
     在其背景颜色上绘制颜色渐变的图层，填充图层的形状（包括圆角）
     您可以使用渐变图层创建包含任意数量颜色的颜色渐变。 默认情况下，颜色在图层之间均匀分布，但您可以选择指定位置，以便通过渐变对颜色位置进行控制。
   */
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    

    //FixMe:
    class func layerClassAdd() -> AnyClass {
        return CAGradientLayer.self
//        let view = AlphaView()
//        view.layer.addSublayer(view.gradientLayer!)
//        return view
    }
    
    func alphaTypeTwo() {
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [(0.0), (0.05), (0.95), (1.0)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0)
    }
    
    func alphaTypeOne() {
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        locations  = [(0.25), (0.5), (0.75)];
        startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
    }
}
