//
//  FavoriteViewController + UITableView.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let favoriteItem = viewModel.favoriteItems[indexPath.row]
        cell.titleLabel.text = favoriteItem.title
        cell.descriptionLabel.text = favoriteItem.description
        cell.priceLabel.text = favoriteItem.price

        if let imageData = favoriteItem.imageData {
            cell.productImageView.image = UIImage(data: imageData)
        } else {
            cell.productImageView.image = UIImage(named: "placeholder")
        }

        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

