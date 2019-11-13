//
//  MaxTempView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class MaxTempView: UIView {

    //最高温度
    var maxTemp: CGFloat = 0
    
    //最低温度
    var minTemp: CGFloat = 0
    
    lazy private var gridView: GridView = GridView()
    
    lazy private var centerLineView = UIView()
    private var centerLineViewStoreValue = CGRectStoreValue()
    
    lazy private var minTempView = UIView()
    private var minTempViewStoreValue = CGRectStoreValue()
    
    lazy private var maxTempView = UIView()
    private var maxTempViewStoreValue = CGRectStoreValue()
    
    lazy private var maxCountView = UIView()
    private var maxCountViewStoreValue = CGRectStoreValue()
    
    lazy private var minCountView = UIView()
    private var minCountViewStoreValue = CGRectStoreValue()
    
    lazy private var maxTempCountLabel: MaxTempCountLabel = MaxTempCountLabel()
    lazy private var minTempCountLabel: MinTempContLabel = MinTempContLabel()
    
    lazy private var titleMoveLabel = TitleMoveLabel.withText(text: "Min/Max Temp")
    
    func buildView() {
        
        let gridOffsetX: CGFloat = 30
        let gridOffSetY: CGFloat = 53
        
        //格子View
        self.gridView.alpha = 0.0
        self.gridView.origin = CGPoint(x: gridOffsetX, y: gridOffSetY)
        self.gridView.gridLength = 30
        
        self.gridView.buildView()
        self.addSubview(gridView)
        
        //中间的横线view
        self.centerLineView.frame = CGRect(x: 0, y: gridView.gridLength * 2, width: gridView.gridLength * 5, height: 1.0)
        self.centerLineView.backgroundColor = UIColor.black
        
        self.centerLineView.frame.origin.x += gridOffsetX
        self.centerLineView.frame.origin.y += gridOffSetY
        self.centerLineViewStoreValue.midRect = self.centerLineView.frame
        self.centerLineView.frame = CGRect(x: 0, y: gridView.gridLength * 2, width: 0.0, height: 1.0)
        self.centerLineViewStoreValue.startRect = self.centerLineView.frame
        self.centerLineView.frame.origin.x = gridView.gridLength * 5
        self.centerLineViewStoreValue.endRect = self.centerLineView.frame
        self.centerLineView.alpha = 0.0
        self.centerLineView.frame = self.centerLineViewStoreValue.startRect
        
        //最小温度
        self.minTempView.frame = CGRect(x: gridView.gridLength, y: gridView.gridLength * 2, width: gridView.gridLength, height: 0)
        self.minTempView.frame.origin.x += gridOffsetX
        self.minTempView.frame.origin.y += gridOffSetY
        self.minTempView.backgroundColor = UIColor.black
        self.minTempView.alpha = 0.0
        self.minTempViewStoreValue.startRect = self.minTempView.frame
        self.addSubview(minTempView)
        
        //最低温度显示
        self.minCountView.frame = CGRect(x: gridView.gridLength, y: gridView.gridLength * 2, width: gridView.gridLength, height: gridView.gridLength)
        self.addSubview(self.minCountView)
        self.minCountView.frame.origin.x += gridOffsetX
        self.minCountView.frame.origin.y += gridOffSetY
        self.minCountViewStoreValue.startRect = self.minCountView.frame
        self.minCountView.alpha = 0.0
        
        // 最大温度
        self.maxTempView.frame = CGRect(x: gridView.gridLength * 3, y: gridView.gridLength * 2, width: gridView.gridLength * 1, height: 0)
        self.maxTempView.frame.origin.x += gridOffsetX
        self.maxTempView.frame.origin.y += gridOffSetY
        self.maxTempView.backgroundColor = UIColor.black
        self.maxTempViewStoreValue.startRect = self.maxTempView.frame
        self.maxTempView.alpha = 0.0
        
        // 最大温度显示
        self.maxCountView.frame = CGRect(x: gridView.gridLength * 3, y: gridView.gridLength * 2, width: gridView.gridLength * 1, height: gridView.gridLength)
        self.addSubview(minCountView)
        self.maxCountView.frame.origin.x += gridOffsetX
        self.maxCountView.frame.origin.y += gridOffSetY
        self.maxCountViewStoreValue.startRect = self.maxCountView.frame
        self.addSubview(maxCountView)
        self.maxCountView.alpha = 0.0
        
        // 最大温度动态显示
        self.maxTempCountLabel.frame = CGRect(x: 0, y: 0, width: 60, height: gridView.gridLength)
        self.maxCountView.addSubview(self.maxTempCountLabel)
        
        // 最小温度动态显示
        self.minTempCountLabel.frame = CGRect(x: 0, y: 0, width: 60, height: gridView.gridLength)
        self.minCountView.addSubview(self.minTempCountLabel)
        
        self.addSubview(self.maxTempView)
        self.addSubview(self.centerLineView)
        
        self.titleMoveLabel.buildView()
        self.addSubview(titleMoveLabel)
        
    }
    
    func show() {
        
        let duration: TimeInterval = 1.75
        
        // 标题显示
        self.titleMoveLabel.show()
        
        // 格子动画效果
        self.gridView.showWithDuration(duration: 1.5)
        
        if (self.minTemp >= 0) {
            
            self.minCountView.frame.origin.y -= self.gridView.gridLength
        }
        
        if (self.maxTemp >= 0) {
            
            self.maxCountView.frame.origin.y -= self.gridView.gridLength
        }
        
        maxTempCountLabel.toValue = self.maxTemp
        maxTempCountLabel.showDuration(duration: duration)
        
        minTempCountLabel.toValue = self.minTemp
        minTempCountLabel.showDuration(duration: duration)
        
        // 中间线条动画效果
        UIView.animate(withDuration: 0.75, animations: { 
            self.centerLineView.frame = self.centerLineViewStoreValue.midRect
            self.centerLineView.alpha = 1.0
            
            self.minTempView.frame.size.height = self.minTemp
            self.minTempView.frame.origin.y     -= self.minTemp
            self.minTempView.alpha  = 1.0
            self.minCountView.frame.origin.y    -= self.minTemp
            self.minCountView.alpha = 1.0
            
            self.maxTempView.frame.size.height = self.maxTemp
            self.maxTempView.frame.origin.y     -= self.maxTemp
            self.maxTempView.alpha  = 1.0
            self.maxCountView.frame.origin.y    -= self.maxTemp
            self.maxCountView.alpha = 1.0

        }) { (_) in
            
        }
      

    }
    
    func hide() {
        
        let duration: TimeInterval = 0.75
        
        // 标题隐藏
        self.titleMoveLabel.hide()
        
        // 格子动画效果
        self.gridView.hideWithDuration(duration: duration)
        
        UIView.animate(withDuration: duration, animations: {
            
            self.centerLineView.alpha = 0.0
            
            self.minTempView.frame = self.minTempViewStoreValue.startRect
            self.minTempView.alpha = 0.0
            
            self.maxTempView.frame = self.maxTempViewStoreValue.startRect
            self.maxTempView.alpha = 0.0
            
            self.minCountView.alpha   = 0.0
            self.minCountView.frame.origin.x += 10.0
            self.maxCountView.alpha   = 0.0
            self.maxCountView.frame.origin.x += 10.0

        }) { (_) in
            
            self.centerLineView.frame = self.centerLineViewStoreValue.startRect
            self.minCountView.frame   = self.minCountViewStoreValue.startRect
            self.maxCountView.frame   = self.maxCountViewStoreValue.startRect
            
        }

    }

}













































