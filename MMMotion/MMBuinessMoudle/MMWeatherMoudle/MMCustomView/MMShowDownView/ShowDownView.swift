//
//  ShowDownView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/30.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ShowDownView: UIView {
    
    lazy private var leftView: PathDirectionView = PathDirectionView(frame: CGRect.zero)
    lazy private var rightView: PathDirectionView = PathDirectionView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width  = frame.width / 2
        let height = frame.height
        
        let leftRect  = CGRect(x: 0, y: 0, width: width, height: height)
        let rightRect = CGRect(x: width, y: 0, width: width, height: height)
        
        leftView.frame  = leftRect
        rightView.frame = rightRect
        rightView.startPointAtRight = true
        self.addSubview(leftView)
        self.addSubview(rightView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showPercent(percent: CGFloat) {
        leftView.showPercent(percent: percent)
        rightView.showPercent(percent: percent)
    }
    
}
