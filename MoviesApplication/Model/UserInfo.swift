//
//  UserInfo.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/26/21.
//

import Foundation


class UserInfo: Codable {
    var email: String!
    var password: String!
    var firstName: String!
    var lastName: String!

    init() {
    }
    
    init(email: String, password: String, firstName: String, lastName: String) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
    }
}
