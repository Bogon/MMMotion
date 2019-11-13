//
//  ConfigAttributedString.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/24.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class ConfigAttributedString {
    
    //富文本属性
    var attribute: NSAttributedString.Key?
    
    //富文本值
    var value: Any!
    
    //富文本范围值
    var range: NSRange?
    
    // 通用型配置
    class func attribute(attribute: NSAttributedString.Key, value: Any, range: NSRange) -> ConfigAttributedString {
        
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = attribute
        config.value     = value
        config.range     = range
        
        return config
        
    }

    // 配置字体
    class func font(font: UIFont, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)
        config.value     = font
        config.range     = range
        
        return config
    }

    
    // 配置字体颜色
    class func foregroundColor(color: UIColor, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)
        config.value     = color
        config.range     = range
        
        return config
    }
    
    // 配置字体背景颜色
    class func backgroundColor(color: UIColor, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.backgroundColor.rawValue)
        config.value     = color
        config.range     = range
        
        return config
    }
    
    // 字体描边颜色以及描边宽度以及阴影(以下两个方法可以一起使用)
    class func strokeColor(color: UIColor, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue)
        config.value     = color
        config.range     = range
        
        return config
    }
    class func strokeWidth(number: Float, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue)
        config.value     = number
        config.range     = range
        
        return config
    }
    class func shadow(shadow: NSShadow, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.shadow.rawValue)
        config.value     = shadow
        config.range     = range
        
        return config
    }
    
    // 配置文字的中划线
    class func strikethroughStyle(number: Int, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.strikethroughStyle.rawValue)
        config.value     = number
        config.range     = range
        
        return config
    }
    
    // 配置文字的下划线
    class func underlineStyle(number: Int, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue)
        config.value     = number
        config.range     = range
        
        return config
    }
    
    // 字间距
    class func kern(number: Float, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.kern.rawValue)
        config.value     = number
        config.range     = range
        
        return config
    }
    
    // 段落样式(需要将UILabel中的numberOfLines设置成0才有用)
    class func paragraphStyle(style: NSMutableParagraphStyle, range: NSRange) -> ConfigAttributedString {
        let config: ConfigAttributedString = ConfigAttributedString()
        
        config.attribute = NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)
        config.value     = style
        config.range     = range
        
        return config
    }
    
}
