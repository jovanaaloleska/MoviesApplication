//
//  Utilities.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import Foundation
import UIKit

class Utilities {
    
    static let sharedInstance = Utilities()
    
    static func createButton(title: String, backgroundColor: UIColor, cornerRadius: CGFloat, titleColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
    
    static func createLabel(title: String, backgroundColor: UIColor, cornerRadius: CGFloat, textColor: UIColor) -> UILabel{
        let label = UILabel()
        label.text = title
        label.layer.cornerRadius = cornerRadius
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        return label
    }
    
    static func createImageView(image: String?, contentMode: UIView.ContentMode) -> UIImageView{
        let imageView = UIImageView()
        if let imageSafe = image {
            imageView.image = UIImage(named: imageSafe)
        }
        imageView.contentMode = contentMode
        return imageView
    }
    static func createTextField(font: UIFont, textColor: UIColor, placeHolder: String, backgroundColor: UIColor, cornerRadius: CGFloat, textAlignment: NSTextAlignment) -> UITextField{
        let textField = UITextField()
        textField.font = font
        textField.textColor = textColor
        textField.placeholder = placeHolder
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = cornerRadius
        textField.textAlignment = textAlignment
        return textField
    }
}
