//
//  CALayer+MaskLayer.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/27.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

extension CALayer {
    
    /**
     *  根据PNG图片创建出用于mask的layer
     *
     *  @param size  mask的尺寸
     *  @param image 用于mask的图片
     *
     *  @return 创建好的mask的layer
     */
    convenience init(size: CGSize, maskPNGImage: UIImage) {
        self.init()
        
        anchorPoint = CGPoint(x: 0, y: 0)
        bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)  // 设置尺寸
        contents = maskPNGImage.cgImage
    }
    class func createMaskLayerWithSize(size: CGSize, maskPNGImage: UIImage) -> CALayer{
  
        let layer = CALayer()
        layer.anchorPoint = CGPoint(x: 0, y: 0)     // 重置锚点
        layer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)  // 设置尺寸

            
        layer.contents = maskPNGImage.cgImage
        return layer
        
    }
    
}
