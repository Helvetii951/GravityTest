//
//  ProductsListViewModel.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

struct ProductViewModel {
    let title : String
    let subtitle : String
    let isFavorite : Bool
    let imageUrl : URL?
    let description : String
    let lat : Double
    let lon : Double
}

class ProductsListViewModel {
    
    let isLoading = Box(false)
    let productModels = Box([ProductViewModel]())
    
    var errorText : String? = nil
    let errorOccured = Box(false)
    
    let networkProductSource: NetworkProductSource
    
    init(networkProductSource: NetworkProductSource) {
        self.networkProductSource = networkProductSource
    }
    
    private var products = [Product]() {
        didSet {
            self.productModels.value = products.map {
                ProductViewModel(title: "\($0.name)(id: \($0.id), \("Price".localized): \($0.price))",
                    subtitle: $0.city,
                    isFavorite: Bool.random(),
                    imageUrl : URL(string: $0.image),
                    description : $0.description,
                    lat : Double($0.latitude)!,
                    lon : Double($0.longitude)!)
            }
        }
    }
    
    var productsCount : Int {
        return productModels.value.count
    }
    
    func productViewModel(at indexPath : IndexPath) -> ProductViewModel {
        return productModels.value[indexPath.row]
    }
    
    func fetchProducts() {
        
        self.isLoading.value = true

        networkProductSource.getProducts { [weak self](res) in
            DispatchQueue.main.async {
                switch res {
                case .error(let e):
                    self?.process(error: e)
                case .success(let arr):
                    self?.process(fetchedProducts: arr)
                }
                self?.isLoading.value = false
            }
        }
    }
    
    fileprivate func process(error : String) {
        self.errorText = error
        self.errorOccured.value = true
    }
    
    fileprivate func process(fetchedProducts : [Product]) {
        self.products = fetchedProducts
    }
}


