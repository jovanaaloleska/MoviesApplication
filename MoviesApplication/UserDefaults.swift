//
//  UserDefaults.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/28/21.
//

import Foundation

class UserPersistence {
    
    static let sharedInstance = UserPersistence()
    var defaults = UserDefaults.standard
    var arrayUsers = [UserInfo]()
    var currentUser = UserInfo()
    
    func setArrayUsers(arrayUsers: Data?) {
        if let safeArrayUsers = arrayUsers {
            defaults.setValue(safeArrayUsers, forKey: "arrayUsers")
        }
    }
    
    func getArrayUsers() -> Data? {
        if let data = defaults.data(forKey: "arrayUsers"){
            return data
        } else {
            return nil
        }
    }
    
    func setCurrrentActiveUser(currentUser: Data?) {
        if let safeCurrentUser = currentUser {
            defaults.setValue(safeCurrentUser, forKey: "currentUser")
        }
    }
    
    func getCurrentActiveUser() -> Data? {
        if let data = defaults.data(forKey: "currentUser"){
            return data
        } else {
            return nil
        }
    }
}
