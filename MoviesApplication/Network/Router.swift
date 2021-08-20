//
//  Router.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/19/21.
//

import Foundation
import Alamofire


enum Router: URLRequestConvertible {
  
    case PopularShows
    case AiringToday
    case UpcomingShows
    case TopRatedShows
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .PopularShows:
            return NetworkConstants.Network.Endpoints.popularShows
        case .AiringToday:
            return NetworkConstants.Network.Endpoints.airingToday
        case .UpcomingShows:
            return NetworkConstants.Network.Endpoints.upcomingShows
        case .TopRatedShows:
            return NetworkConstants.Network.Endpoints.topRatedShows
        }
    }
    
    var parameters: [String:Any] {
        switch self {
        default:
            return [:]
        }
    }
    
    var header: [String:String] {
        switch self {
        default:
            return [:]
        }
    }
 
    func asURLRequest() throws -> URLRequest {
        var url: URL
        url = URL(string: NetworkConstants.Network.baseUrl+path) ?? URL(string: "")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if method.rawValue != "GET" {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        urlRequest.allHTTPHeaderFields = header
        
        return urlRequest
    }
}
