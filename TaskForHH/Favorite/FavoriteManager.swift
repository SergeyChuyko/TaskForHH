//
//  FavoriteManager.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favorites"

    private init() {}

    func saveFavorite(title: String, description: String, price: String, image: UIImage) {
        var favorites = getFavorites()
        let favorite = FavoriteItem(title: title, description: description, price: price, imageData: image.pngData())
        favorites.append(favorite)
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
        print("Saved Favorite: \(favorite)")
        printAllFavorites()
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }

    func getFavorites() -> [FavoriteItem] {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let favorites = try? JSONDecoder().decode([FavoriteItem].self, from: data) {
            return favorites
        }
        return []
    }

    func removeFavorite(title: String) {
        var favorites = getFavorites()
        favorites.removeAll { $0.title == title }
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
        print("Removed Favorite: \(title)")
        printAllFavorites()
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }

    func isFavorite(title: String) -> Bool {
        let favorites = getFavorites()
        return favorites.contains { $0.title == title }
    }

    private func printAllFavorites() {
        let favorites = getFavorites()
        print("All Favorites:")
        for favorite in favorites {
            print(favorite)
        }
    }
}

struct FavoriteItem: Codable {
    let title: String
    let description: String
    let price: String
    let imageData: Data?
}

extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}
