//
//  MMNewsAPIViewModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PromiseKit
import ObjectMapper
import CCNetwokingKit
import Moya

private let key: String = "0e43f7b160af7a61149a62ae2f83948d"

class MMNewsAPIViewModel {
    
    private let disposeBag = DisposeBag()
    private let provider:MoyaProvider = MoyaProvider<MMNewsAPI>(manager: GeekSecurityCertificationProvider.manager(), plugins: [])
    
    internal static let shared = MMNewsAPIViewModel()
    fileprivate var page: Int = 1
    
    private init() {}
    
    /*******************************************| START - 生活助手 - START |*************************************/
    
    /// 体育实时信息接口
    ///
    /// - Parameter value: 必填字段：v
    /// - Returns: 今日信息数据Model
    func getNews(WithCache isCache: Bool) -> Promise<MMSportsNewsResposeModel> {
        self.page = 1
        return Promise { seal in
            let value: [String: String] = ["type": "tiyu", "key": key]
            provider.requestJson(.getSportsNews(value: value), isCache: isCache)
                .mapObject(type:MMSportsNewsResposeModel.self)
                .subscribe(onNext: { model in
                    seal.fulfill(model)
                }, onError: {
                    seal.reject($0)
                }).disposed(by: disposeBag)
        }
    }
    
    /// 体育实时信息接口
    ///
    /// - Parameter value: 必填字段：v
    /// - Returns: 今日信息数据Model
    func load(WithCache isCache: Bool) -> Promise<MMSportsNewsResposeModel> {
        self.page += 1
        return Promise { seal in
            let value: [String: String] = ["type": "tiyu", "key": key]
            provider.requestJson(.getSportsNews(value: value), isCache: isCache)
                .mapObject(type:MMSportsNewsResposeModel.self)
                .subscribe(onNext: { model in
                    seal.fulfill(model)
                }, onError: {
                    seal.reject($0)
                }).disposed(by: disposeBag)
        }
    }
}
