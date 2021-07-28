//
//  Extensions.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/27/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(with title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
