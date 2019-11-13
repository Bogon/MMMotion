//
//  MMMainController+Delegate.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import UIKit

extension MMMainController {

    /// 计算并注册监听事件
    func registerObserver() {
        self.scrollView.rx.contentOffset.subscribe(onNext: { contentOffset in
            if contentOffset.y > 88 {
                self.view.backgroundColor = UIColor.white
            } else {
                self.view.backgroundColor = UIColor.init(hex: "#EF2971")
                
            }
        }).disposed(by: disposeBag)

    }
}
