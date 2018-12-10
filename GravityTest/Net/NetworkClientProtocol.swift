//
//  NetworkProtocol.swift
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

enum NetworkClientError : Error {
    case invalidUrl(String)
}

protocol NetworkClientProtocol {
    
    typealias RequestCompletion = (Data?, Error?) -> Void
    
    func get(url : String, headers : [String : String]?, action : String?, params : [String : Any]?, completion : @escaping RequestCompletion)
    func get(url : String, headers : [String : String]?, queryString : String?, completion : @escaping RequestCompletion)
    
    func post(url : String, headers : [String : String]?,postBody : Data?, completion : @escaping RequestCompletion)
    func post(url : String, headers : [String : String]?, params : [String : Any]?, completion : @escaping RequestCompletion)
}
