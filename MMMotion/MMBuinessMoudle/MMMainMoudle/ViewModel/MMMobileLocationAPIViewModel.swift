//
//  MMMobileLocationAPIViewModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/4.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PromiseKit
import ObjectMapper
import CCNetwokingKit
import Moya

private let key: String = "b06a825a702cfa77a6ac8caa4d637a5c"

class MMMobileLocationAPIViewModel {
    
    private let disposeBag = DisposeBag()
    private let provider:MoyaProvider = MoyaProvider<MMFindPhoneNumberLocationAPI>(manager: GeekSecurityCertificationProvider.manager(), plugins: [])
    
    internal static let shared = MMMobileLocationAPIViewModel()
    private init() {}
    
    /*******************************************| START - 生活助手 - START |*************************************/
    /// 手机号码所在地信息接口
    ///
    /// - Parameter value: 必填字段：v
    /// - Returns: 今日信息数据Model
    func getMobileInfo(WithCache isCache: Bool, mobile: String) -> Promise<MMMobileLocationResponseModel> {
        return Promise { seal in
            let value: [String: String] = ["phone": mobile, "dtype": "json", "key": key]
            provider.requestJson(.getMobile(value: value), isCache: isCache)
                .mapObject(type:MMMobileLocationResponseModel.self)
                .subscribe(onNext: { model in
                    seal.fulfill(model)
                }, onError: {
                    seal.reject($0)
                }).disposed(by: disposeBag)
        }
    }
}

