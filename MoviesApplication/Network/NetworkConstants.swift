//
//  NetworkConstants.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/19/21.
//

import Foundation

class NetworkConstants {
    
    struct Network {
        static let baseUrl = "https://api.themoviedb.org/3"
        
        static let apiKey = "8656f7220903ba11a05eb50a50bed1e6"
        
        static let headers = ["Content-Type":"application/json"]
        
        static let currentPage = 1
        
        struct Endpoints {
            static let popularShows = "/tv/popular?api_key=\(Network.apiKey)&page=\(Network.currentPage)"
            static let airingToday = "/tv/airing_today?api_key=\(Network.apiKey)&page=\(Network.currentPage)"
            static let onTheAirShows = "/tv/on_the_air?api_key=\(Network.apiKey)&page=\(Network.currentPage)"
            static let topRatedShows = "/tv/top_rated?api_key=\(Network.apiKey)&page=\(Network.currentPage)"
        }
    }
}
