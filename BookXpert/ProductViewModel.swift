//
//  ProductViewModel.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import Foundation

class ProductViewModel {
    private let apiService = NetworkService()
    var products: [Product] = []
    var reloadUI: (() -> Void)?

    func fetchProducts() {
        apiService.fetchProducts { [weak self] result in
            switch result {
            case .success(let items):
                self?.products = items
                self?.reloadUI?()
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }

    func product(at index: Int) -> Product {
        return products[index]
    }

    var count: Int {
        return products.count
    }
}
