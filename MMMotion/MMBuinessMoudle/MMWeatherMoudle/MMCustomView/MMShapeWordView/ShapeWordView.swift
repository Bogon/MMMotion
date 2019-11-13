//
//  ShapeWordView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ShapeWordView: UIView {

    private let label = UILabel()
    var text: String = ""
    var font: UIFont?
    var lineColor: UIColor?
    var lineWidth: CGFloat = 0
    
    private var shapeLayer: CAShapeLayer?
    
    func buildView() {
        // 过滤数据
      //  let lineWidth: CGFloat = (self.lineWidth <= 0 ? 0.5 : self.lineWidth)
        let font: UIFont = (self.font == nil ? UIFont.systemFont(ofSize: 18) : self.font!)
        let lineColor: UIColor = (self.lineColor == nil ? UIColor.black : self.lineColor!)
        let text = self.text
        
        label.text = text
        label.font = font
        label.textColor = lineColor
        label.textAlignment = .center
        label.frame = self.frame
        self.addSubview(label)
        

        
//        if text.characters.count == 0 {
//            
//            return
//        }
//        
//        // 初始化layer
//        shapeLayer = CAShapeLayer()
//        guard let shapeLayer = self.shapeLayer else {
//            return
//        }
//        shapeLayer.frame = self.bounds
//        shapeLayer.lineWidth = lineWidth
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = lineColor.cgColor
//        
//        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
//        paragraphStyle.alignment = .center
//        //FixMe:
//        let attrString: NSAttributedString = NSAttributedString(string: text, attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle])
//        
//        shapeLayer.bounds = (shapeLayer.path?.boundingBox)!
//        shapeLayer.isGeometryFlipped = true //一个布尔值，指示层及其子层的几何是否垂直翻转
//        shapeLayer.strokeEnd = 0
//        self.layer.addSublayer(shapeLayer)
      //  shapeLayer.path = UIBezierPath
        //[UIBezierPath pathForMultilineString:text
//            withFont:font
//            maxWidth:self.bounds.size.width
//            textAlignment:NSTextAlignmentCenter].CGPath;

    }
    
    func percent(percent: CGFloat, animated: Bool) {
        if (animated) {
            
            if (percent <= 0) {
                
                self.shapeLayer?.strokeEnd = 0
                
            } else if (percent > 0 && percent <= 1) {
                
                self.shapeLayer?.strokeEnd = percent
                
            } else {
                
                self.shapeLayer?.strokeEnd = 1
            }
            
        } else {
            
//            if (percent <= 0) {
//                CATransaction.setDisableActions(true)
//                self.shapeLayer?.strokeEnd = 0
//                CATransaction.setDisableActions(false)
//                
//            } else if (percent > 0 && percent <= 1) {
//                CATransaction.setDisableActions(true)
//                self.shapeLayer?.strokeEnd = percent
//                CATransaction.setDisableActions(false)
//                
//            } else {
//                
//                CATransaction.setDisableActions(true)
//                self.shapeLayer?.strokeEnd = 1
//                CATransaction.setDisableActions(false)
//            }
        }

    }


}
