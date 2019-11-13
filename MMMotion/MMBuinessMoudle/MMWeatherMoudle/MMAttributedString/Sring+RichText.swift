//
//  Sring+RichText.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/24.
//  Copyright © 2017年 王伟奇. All rights reserved.
//
import Foundation

extension String {
    
    func createAttributedStringAndConfig(configs: Array<Any>) -> NSMutableAttributedString {
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        
        for item in configs {
            let oneConfig: ConfigAttributedString = item as! ConfigAttributedString
            attributedString.addAttributes([oneConfig.attribute! : oneConfig.value], range: oneConfig.range!)
        }
        
        return attributedString
    }
    
    func rangeFrom(string: String) -> NSRange { //Range<String.Index>
        let range = string.range(of: self)
        return string.nsRange(from: range!)
    }
    
    func range() -> NSRange {
        return NSMakeRange(0, self.count)
    }

  

}



