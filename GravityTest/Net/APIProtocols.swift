//
//  APIProtocols.swift
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

enum ApiResult<T> {
    case success(T)
    case error(String)
}

protocol NetworkProductSource {
    func getProducts(completion : @escaping (ApiResult<[Product]>) -> Void)
}
