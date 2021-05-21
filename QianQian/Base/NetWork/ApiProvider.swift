//
//  ApiProvider.swift
//  QianQian
//
//  Created by 李博 on 2021/4/7.
//

import UIKit
import Moya
import HandyJSON
import ProgressHUD

let progressPlugin = NetworkActivityPlugin { (type, target) in
    switch type {
    case .began:
        ProgressHUD.show()
    case .ended:
        ProgressHUD.dismiss()
    }
}

let requestClosure = { (endpoint: Endpoint, closure: MoyaProvider<QianApi>.RequestResultClosure) in
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<QianApi>(requestClosure: requestClosure, plugins: [progressPlugin])

enum QianApi {
    case home(appid: Int,sign: String,timestamp: Int64)
    case tracklist(id: Int,appid: Int,sign: String,timestamp: Int64,pageNo: Int,pageSize: Int,type: Int)
}

extension QianApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api-qianqian.taihe.com")!
    }
    
    var path: String {
        switch self {
        case .home:
            return "v1/index"
        case .tracklist:
            return "v1/tracklist/info"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case .home(let appid,let sign,let timestamp):
            parmeters["appid"] = appid
            parmeters["sign"] = sign
            parmeters["timestamp"] = timestamp
        case .tracklist(let id,let appid,let sign,let timestamp,let pageNo,let pageSize,let type):
            parmeters["id"] = id
            parmeters["appid"] = appid
            parmeters["sign"] = sign
            parmeters["timestamp"] = timestamp
            parmeters["pageNo"] = pageNo
            parmeters["pageSize"] = pageSize
            parmeters["type"] = type
        default:
            break
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}


