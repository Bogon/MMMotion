//
//  LineBackgroundView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class LineBackgroundView: UIView {

    var lineWidth: CGFloat = 0
    var lineGap: CGFloat = 0
    var lineColor: UIColor?
    
    //容器
    lazy private var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        if (self.lineGap <= 0 && self.lineWidth <= 0) {
            
            return
        }
        
        // 获取长度
        let width  = self.bounds.size.width
        let height = self.bounds.size.height
        let containerViewWidth = (width + height) * 0.75
        
        // 初始化containView
        containerView.frame = CGRect(x: 0, y: 0, width: containerViewWidth, height: containerViewWidth)
        containerView.layer.borderWidth = 1
        containerView.center = CGPoint(x: width / 2, y: height / 2)
        
        let lineViewCount: Int = Int(containerViewWidth / (self.lineGap + self.lineWidth))
        
        for i in 0...lineViewCount {
            
            let tempView = UIView(frame: CGRect(x: CGFloat(i) * (self.lineGap +  self.lineWidth), y: 0, width: self.lineWidth, height: containerViewWidth))
            
            if ((self.lineColor) != nil) {
                
                tempView.backgroundColor = self.lineColor
                
            } else {
                
                tempView.backgroundColor = UIColor.black
            }
            
            self.containerView.addSubview(tempView)
        }

        self.containerView.transform = containerView.transform.rotated(by: (CGFloat.pi * 45) / 180)
        self.addSubview(containerView)

    }
    
    class func createViewWithFrame(frame: CGRect, lineWidth: CGFloat, lineGap: CGFloat, lineColor: UIColor) -> LineBackgroundView {
        
        let bgView: LineBackgroundView = LineBackgroundView(frame: frame)
        bgView.lineWidth           = lineWidth
        bgView.lineGap             = lineGap
        bgView.lineColor           = lineColor
        bgView.buildView()
        
        return bgView
    }

}
