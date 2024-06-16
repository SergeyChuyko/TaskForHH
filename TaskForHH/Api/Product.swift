//
//  Product.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

struct Product: Codable {
    let title: String
    let price: Double
    let image: String
    let description: String
    var loadedImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case title
        case price
        case image
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Double.self, forKey: .price)
        image = try container.decode(String.self, forKey: .image)
        description = try container.decode(String.self, forKey: .description)
        loadedImage = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(price, forKey: .price)
        try container.encode(image, forKey: .image)
        try container.encode(description, forKey: .description)
    }
}
