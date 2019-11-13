//
//  GridView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class GridView: UIView {
    
   // var layereee = CAGradientLayer()

    private var alphaView: AlphaView  = AlphaView()
    
    //坐标点
    var origin: CGPoint = CGPoint.zero
    
    //小格的宽度
    var gridLength: CGFloat = 0
    
    func buildView() {
        
        
        let gridLength: CGFloat = self.gridLength <= 0 ? 10.0 : self.gridLength
        
        // 水平线条的个数
        let horizontalLineCount = 5;
        for i in 0..<horizontalLineCount {
            let rect = CGRect(x: 0, y: gridLength * CGFloat(i), width: gridLength * CGFloat(horizontalLineCount), height: 0.5)
            let line = UIView(frame: rect)
            line.backgroundColor = UIColor(hexString: "C2C2C2")
            
            if (i == 0) {
                
                line.alpha = 0.0
                
            } else if (i == horizontalLineCount - 1) {
                
                line.alpha = 0.0
            }
            
            self.addSubview(line)
    
        }
        
        
        // 垂直线的个数
        let verticalLineCount = 6
        for i in 0..<verticalLineCount {
            let rect = CGRect(x: gridLength * CGFloat(i), y: 0, width: 0.5, height: gridLength * CGFloat(verticalLineCount - 2))
            let line = UIView(frame: rect)
            line.backgroundColor = UIColor(hexString: "C2C2C2")
            
            if (i == 0) {
                
                line.alpha = 0.0
                
            } else if (i == verticalLineCount - 1) {
                
                line.alpha = 0.0
            }
            self.addSubview(line)
        }

        let size = CGSize(width: CGFloat(verticalLineCount)   * gridLength, height: CGFloat(horizontalLineCount) * gridLength)
        self.frame = CGRect(origin: self.origin, size: size)

        
        alphaView.frame = self.bounds
        alphaView.alphaTypeOne()
        self.mask = self.alphaView

    }
    
    //显示时长
    func showWithDuration(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: { 
            self.alphaView.frame.origin.x = -5
            self.alpha = 1.0
        }) { (_) in
            
        }
    }
    
    //隐藏时长
    func hideWithDuration(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: { 
            self.alphaView.frame.origin.x = self.frame.width
            self.alpha       = 0.0
        }) { (_) in
            self.alphaView.frame.origin.x = -self.frame.width
        }
    }

}
