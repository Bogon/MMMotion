//
//  MMScrollViewHandler.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import UIKit

class MMScrollViewHandler {
    
    internal static let shared = MMScrollViewHandler()
    private init() {}
    
    /// 快速创建一个ScrollView
    public func getScrollView() -> UIScrollView {
        let contentScrollView:UIScrollView = UIScrollView.init()
        contentScrollView.contentSize = UIScreen.ol_size
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.keyboardDismissMode = .interactive
        return contentScrollView
    }
}
