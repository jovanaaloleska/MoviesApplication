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
    
    static func createButtonWithImage(name: String, backgroundColor: UIColor, cornerRadius: CGFloat, titleColor: UIColor) -> UIButton
    {
        let button = UIButton()
        button.setImage(UIImage(named: name), for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
    
    static func createLabel(title: String, backgroundColor: UIColor, cornerRadius: CGFloat, textColor: UIColor, font: UIFont) -> UILabel{
        let label = UILabel()
        label.text = title
        label.layer.cornerRadius = cornerRadius
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.font = font
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
    
    func getIphoneType() -> PhoneType {
        let bounds = UIScreen.main.bounds
        let maxLength = max(bounds.size.height, bounds.size.width)
        if (maxLength <= 568) {
            return .Small
        } else if (maxLength > 568) && (maxLength <= 667) {
            return .Medium
        } else if (maxLength > 667) && (maxLength <= 736) {
            return .Large
        } else if (maxLength > 736) && (maxLength <= 895) {
            return .XLarge
        } else {
            return .MaxLarge
        }
    }
    
    func encodingToData(source: UIImage) -> Data? {
        return source.pngData()
    }
    
    func encodeUserToData(user: UserInfo) -> Data {
        var data = Data()
        do {
            let encoder = JSONEncoder()
            data = try encoder.encode(user)
           // UserPersistence.sharedInstance.setCurrrentActiveUser(currentUser: data)
        } catch {
            print("Unable to encode User info (\(error)")
        }
        return data
    }
    
    func jsonToData(json: Any) -> Data? {
            do {
                return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let myJSONError {
                print(myJSONError)
            }
            return nil
        }
    
    func getBaseUrlForImage() -> String {
            return "https://image.tmdb.org/t/p/w500/"
        }
}
