//
//  AlertHelper.swift
//  TaskForHH
//
//  Created by Sergo on 17.06.2024.
//

import UIKit

class AlertHelper {
    static func showAlert(on viewController: UIViewController, withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)

        if let primaryColor = UIColor(named: "primary-color") {
            okAction.setValue(primaryColor, forKey: "titleTextColor")
        }

        viewController.present(alert, animated: true, completion: nil)
    }
}
