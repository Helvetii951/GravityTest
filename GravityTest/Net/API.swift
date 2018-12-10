//
//  API.swift
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

class API {
    let baseUrl = "https://api.myjson.com"
    
    let networkClient : NetworkClientProtocol
    
    init(networkClient : NetworkClientProtocol) {
        self.networkClient = networkClient
    }
}

extension API : NetworkProductSource {
    func getProducts(completion: @escaping (ApiResult<[Product]>) -> Void) {
        networkClient.get(url: baseUrl, headers: nil, queryString: "/bins/vk6qe") { (data, error) in
            if let err = error {
                completion(.error(err.localizedDescription))
            } else {
                guard let data = data, let productArr = try? JSONDecoder().decode([Product].self, from: data) else {
                    completion(.error("Empty data".localized))
                    return
                }
                completion(.success(productArr))
            }
        }
    }
}
