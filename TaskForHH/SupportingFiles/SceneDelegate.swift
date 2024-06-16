//
//  SceneDelegate.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let shopViewModel = ShopViewModel()
        let shopViewController = ShopViewController(viewModel: shopViewModel)
        let favoriteViewController = FavoriteViewController()

        let shopNavController = UINavigationController(rootViewController: shopViewController)
        let favoriteNavController = UINavigationController(rootViewController: favoriteViewController)

        shopViewController.tabBarItem = UITabBarItem(title: "Shop", image: UIImage(systemName: "cart"), tag: 0)
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [shopNavController, favoriteNavController]

        UITabBar.appearance().tintColor = UIColor(named: "primary-color")
        UINavigationBar.appearance().tintColor = UIColor(named: "primary-color")

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
