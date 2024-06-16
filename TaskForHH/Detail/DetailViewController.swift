//
//  DetailViewController.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

class DetailViewController: UIViewController {

    var titleText: String?
    var descriptionText: String?
    var priceText: String?
    var productImage: UIImage?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "customDark-color")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(named: "customGrayBlue-color")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        label.textColor = UIColor(named: "customDark-color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setConstraints()
        setupNavigationBar()

        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        priceLabel.text = priceText
        productImageView.image = productImage

        navigationItem.title = titleText

        isFavorite = FavoritesManager.shared.isFavorite(title: titleText ?? "")
        updateFavoriteButton()
    }

    private var isFavorite: Bool = false

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(named: "primary-color")
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
        updateFavoriteButton()
    }

    @objc private func favoriteButtonTapped() {
        isFavorite.toggle()
        if isFavorite {
            guard let titleText = titleText, let descriptionText = descriptionText, let priceText = priceText, let productImage = productImage else { return }
            FavoritesManager.shared.saveFavorite(title: titleText, description: descriptionText, price: priceText, image: productImage)
            AlertHelper.showAlert(on: self, withTitle: "Saved", message: "Item has been added to favorites.")
        } else {
            if let titleText = titleText {
                FavoritesManager.shared.removeFavorite(title: titleText)
            }
        }
        updateFavoriteButton()
    }

    private func updateFavoriteButton() {
        let starImageName = isFavorite ? "star.fill" : "star"
        let fillColor = isFavorite ? UIColor(named: "primary-color") ?? .black : UIColor(named: "customGray-color") ?? .gray
        let starImage = UIImage(systemName: starImageName)?.withTintColor(fillColor, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem?.image = starImage
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 300),

            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
