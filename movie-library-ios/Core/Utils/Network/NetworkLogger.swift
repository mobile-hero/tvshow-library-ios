//
//  NetworkLogger.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 12/10/22.
//

import Foundation
import Alamofire

class NetworkLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "com.mobile-hero.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print(request.request!.url!)
        print(request.description)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print(request.request!.url!)
        guard let data = response.data else {
            return
        }
        print(data)
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
