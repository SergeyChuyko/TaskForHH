//
//  ApiClient.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

class APIClient {
    func fetchProducts(completion: @escaping ([Product]?) -> Void) {
        let url = URL(string: "https://fakestoreapi.com/products")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                var products = try JSONDecoder().decode([Product].self, from: data)

                let group = DispatchGroup()
                for (index, product) in products.enumerated() {
                    if let url = URL(string: product.image) {
                        group.enter()
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                products[index].loadedImage = image
                            }
                            group.leave()
                        }
                    }
                }

                group.notify(queue: .main) {
                    completion(products)
                }

            } catch {
                completion(nil)
            }
        }.resume()
    }
}
