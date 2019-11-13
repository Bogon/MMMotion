//
//  MMHistoryInTodayAPIViewModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PromiseKit
import ObjectMapper
import CCNetwokingKit
import Moya

private let key: String = "af0798998c25b07ef4a00755b1c2d4e2"
private let version: String = "1.0"

class MMHistoryInTodayAPIViewModel {
    
    private let disposeBag = DisposeBag()
    private let provider:MoyaProvider = MoyaProvider<MMHistoryInTodayAPI>(manager: GeekSecurityCertificationProvider.manager(), plugins: [])
    
    internal static let shared = MMHistoryInTodayAPIViewModel()
    private init() {}
    
    /*******************************************| START - 生活助手 - START |*************************************/
    /// 历史上的今日信息接口
    ///
    /// - Parameter value: 必填字段：v
    /// - Returns: 今日信息数据Model
    func getTalkingInfo(WithCache isCache: Bool) -> Promise<MMHistoryInTodayResponseModel> {
        return Promise { seal in
            let value: [String: String] = ["v": version, "month": "\(Date().getMonth())", "day": "\(Date().getDay())", "key": key]
            provider.requestJson(.getHistoryInToday(value: value), isCache: isCache)
                .mapObject(type:MMHistoryInTodayResponseModel.self)
                .subscribe(onNext: { model in
                    seal.fulfill(model)
                }, onError: {
                    seal.reject($0)
                }).disposed(by: disposeBag)
        }
    }
}

