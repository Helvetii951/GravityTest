//
//  NetworkClient.swift
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

class SimpleNetworkClient: NetworkClientProtocol {
    func get(url: String, headers: [String : String]?, action: String?, params: [String : Any]?, completion: @escaping RequestCompletion) {
        
        var queryStr = ""
        
        if let action = action {
            queryStr += action
        }
        
        if let params = params, params.count > 0 {
            queryStr = "?" + params.map{"\($0)=\($1)"}.joined(separator: "&")
        }
        
        get(url: url, headers: headers, queryString: queryStr, completion: completion)
    }
    
    
    func get(url: String, headers: [String : String]?, queryString: String?, completion: @escaping RequestCompletion) {
        let finalUrl = queryString == nil ? url : url + queryString!
        makeRequest(method: "GET", url: finalUrl, headers: headers, httpBody: nil, params: nil, completion: completion)
    }
    
    func post(url: String, headers: [String : String]?, postBody: Data?, completion: @escaping RequestCompletion) {
        makeRequest(method: "POST", url: url, headers: headers, httpBody: postBody, params: nil, completion: completion)
    }
    
    func post(url: String, headers: [String : String]?, params: [String : Any]?, completion: @escaping RequestCompletion) {
        if let params = params, params.count > 0 {
            let bodyData = params.map{"\($0)=\($1)"}.joined(separator: "&").data(using: .utf8)
            if let bd = bodyData {
                makeRequest(method: "POST", url: url, headers: headers, httpBody: bd, params: nil, completion: completion)
                return
            }
            makeRequest(method: "POST", url: url, headers: headers, httpBody: nil, params: nil, completion: completion)
        }
    }
    
    private func makeRequest(method : String, url: String, headers: [String : String]? = nil, httpBody : Data? = nil,  params: [String : Any]? = nil, completion: @escaping RequestCompletion) {
        
        guard let targetUrl = URL(string: url) else {
            completion(nil, NetworkClientError.invalidUrl("Wrong URL: \(url)"))
            return
        }
        
        var request = URLRequest(url: targetUrl)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, error)
            }
        }
        task.resume()
    }
    
}
