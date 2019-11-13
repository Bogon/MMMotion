//
//  Double+RoundTo.swift
//  weather
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

import Foundation
extension Double {
    //保留后几位
    public func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
