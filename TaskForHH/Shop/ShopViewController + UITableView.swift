//
//  ShopViewController + UITableView.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

extension ShopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let product = viewModel.products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "$\(product.price)"

        cell.productImageView.image = product.loadedImage ?? UIImage(named: "placeholder")

        return cell
    }
}

extension ShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.titleText = product.title
        detailVC.descriptionText = product.description
        detailVC.priceText = "$\(product.price)"
        detailVC.productImage = product.loadedImage
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

