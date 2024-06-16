//
//  FavoriteViewModel.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

class FavoriteViewModel {
    var favoriteItems: [FavoriteItem] = []

    func fetchFavorites(completion: @escaping () -> Void) {
        favoriteItems = FavoritesManager.shared.getFavorites()
        completion()
    }
}
