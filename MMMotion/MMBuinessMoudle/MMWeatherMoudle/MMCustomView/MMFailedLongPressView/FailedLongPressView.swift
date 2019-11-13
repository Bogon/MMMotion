//
//  FailedLongPressView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/31.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

@objc protocol FailedLongPressViewDelegate: NSObjectProtocol {
    
    @objc func pressEvent(view: FailedLongPressView)
}

class FailedLongPressView: UIView {

    weak var delegate: FailedLongPressViewDelegate?
    
    //制作背景阴影view
    lazy private var lineBackgroundView: LineBackgroundView = LineBackgroundView()
    
    //长按按钮
    lazy private var pressButton: PressAnimationButton = PressAnimationButton(frame: CGRect(x: 0, y: 0, width: Width - 30, height: 48))
    private var pressButtonStoreValue: CGRectStoreValue = CGRectStoreValue()
    
    lazy private var iconImageView = UIImageView(image: #imageLiteral(resourceName: "cover"))
    private var iconImageViewStoreValue: CGRectStoreValue = CGRectStoreValue()
    
    func buildView() {
        
        // 封面图标
        iconImageView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        iconImageView.center = self.center
        iconImageView.frame.origin.y -= 100
        self.addSubview(iconImageView)

        iconImageViewStoreValue.midRect = iconImageView.frame
        iconImageView.frame.origin.y -= 20
        iconImageViewStoreValue.startRect = iconImageView.frame
        iconImageView.frame.origin.y += 40
        iconImageViewStoreValue.endRect = iconImageView.frame
        iconImageView.frame = iconImageViewStoreValue.startRect
        iconImageView.alpha = 0
        
        // 背景view
        lineBackgroundView = LineBackgroundView.createViewWithFrame(frame: self.bounds, lineWidth: 4, lineGap: 4, lineColor: UIColor.black.withAlphaComponent(0.035))
        self.addSubview(lineBackgroundView)
 

        // 长按按钮
        self.addSubview(pressButton)
        pressButton.titleLabel?.font = UIFont(name: LATO_LIGHT, size: 20)
        pressButton.layer.borderColor = UIColor.black.cgColor
        
        pressButton.layer.borderWidth = 0.5
        pressButton.setAnimationColor(color: UIColor.black)
        pressButton.animationWidth = Width - 110
        pressButton.setTitle("Long Press To Update", for: .normal)
        pressButton.setTitleColor(UIColor.black, for: .normal)
        pressButton.setTitleColor(UIColor.white, for: .highlighted)
        pressButton.center = self.center
        pressButton.frame.origin.y = self.frame.height - 60
        pressButton.delegate = self
        
        pressButtonStoreValue.midRect = pressButton.frame
        pressButton.frame.origin.y -= 20
        pressButtonStoreValue.startRect = pressButton.frame
        pressButton.frame.origin.y += 25
        pressButtonStoreValue.endRect = pressButton.frame
        pressButton.frame = pressButtonStoreValue.startRect
        pressButton.alpha = 0

    }
    
    func show() {
        
        UIView.animate(withDuration: 1, animations: { 
            
            self.pressButton.frame = self.pressButtonStoreValue.midRect
            self.pressButton.alpha = 1
            
            self.iconImageView.frame    = self.iconImageViewStoreValue.midRect
            self.iconImageView.alpha    = 1
            
        }) { (_) in
            
        }
    }
    
    func hide() {
        
        UIView.animate(withDuration: 1, animations: { 
            
            self.pressButton.frame = self.pressButtonStoreValue.endRect
            self.pressButton.alpha = 0
            
            self.iconImageView.frame    = self.iconImageViewStoreValue.endRect
            self.iconImageView.alpha    = 0

        }) { (_) in
            
            self.pressButton.frame = self.pressButtonStoreValue.startRect
            self.iconImageView.frame    = self.iconImageViewStoreValue.startRect
        }
    }
    
    func remove() {
        
        UIView.animate(withDuration: 1, animations: { 
            self.lineBackgroundView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }

}

//MARK: - pressAnimationButton 代理方法
extension FailedLongPressView: PressAnimationButtonDelegate {
    
    func finishedEventWith(button: PressAnimationButton) {
        NSLog("长按效果")
        if delegate != nil, delegate!.responds(to: #selector(delegate!.pressEvent(view:))) {
            
            delegate?.pressEvent(view: self)
        }
    }
}
