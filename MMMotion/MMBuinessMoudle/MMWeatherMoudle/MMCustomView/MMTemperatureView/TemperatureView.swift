//
//  TemperatureView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class TemperatureView: UIView {

    //温度
    var temperature: Int = 0
    
    lazy private var countLabel = TemperatureCountLabel(frame: CGRect(x: 0, y: 0, width: 160, height: 140))
    
    private var countLabelStoreValue = CGRectStoreValue()
    
    lazy var titleMoveLabel: TitleMoveLabel = TitleMoveLabel.withText(text: "Temperature")
    
    func buildView() {

        countLabel.center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        self.addSubview(countLabel)
        
        countLabelStoreValue.midRect   = self.countLabel.frame
        countLabel.frame.origin.x     += 10
        countLabelStoreValue.startRect = self.countLabel.frame
        countLabel.frame.origin.x     -= 20;
        countLabelStoreValue.endRect   = self.countLabel.frame
        countLabel.frame = self.countLabelStoreValue.startRect
        
        self.addSubview(self.titleMoveLabel)
    }
    
    func show() {
        
        
        let duration: TimeInterval = 1.75
        
        countLabel.toValue = CGFloat(temperature);
        countLabel.showDuration(duration: duration)
        titleMoveLabel.show()
        
        UIView.animate(withDuration: TimeInterval(duration)) { 
            self.countLabel.frame = self.countLabelStoreValue.midRect
        }
    }
    
    func hide() {
        
        let duration: TimeInterval = 0.75
        self.countLabel.hideDuration(duration: duration)
        self.titleMoveLabel.hide()
        
        UIView.animate(withDuration: duration, animations: { 
            self.countLabel.frame = self.countLabelStoreValue.endRect
        }) { (_) in
            self.countLabel.frame = self.countLabelStoreValue.startRect
        }
    }

}
