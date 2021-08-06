//
//  UserInfo.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/26/21.
//

import Foundation


class UserInfo: Codable {
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var profilePicture: Data?
    var imageFbUrl: String?
    var imageGoogleUrl: URL?
    var id: String?

    init() {
    }
    
    init(email: String, password: String, firstName: String, lastName: String, profilePicture: Data?, imageFbUrl: String?, imageGoogleUrl: URL?, id: String?) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.imageFbUrl = imageFbUrl
        self.imageGoogleUrl = imageGoogleUrl
        self.id = id
    }
}
