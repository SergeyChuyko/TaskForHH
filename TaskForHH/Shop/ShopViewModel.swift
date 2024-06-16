//
//  ShopViewModel.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

class ShopViewModel {
    var products: [Product] = []

    func fetchProducts(completion: @escaping () -> Void) {
        let apiClient = APIClient()
        apiClient.fetchProducts { [weak self] products in
            guard let products = products else {
                completion()
                return
            }
            self?.products = products

            let group = DispatchGroup()
            for (index, product) in products.enumerated() {
                if let url = URL(string: product.image) {
                    group.enter()
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                            self?.products[index].loadedImage = image
                        }
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                completion()
            }
        }
    }
}
