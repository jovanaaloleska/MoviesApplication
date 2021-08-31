//
//  Router.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/19/21.
//

import Foundation
import Alamofire


enum Router: URLRequestConvertible {
  
    case PopularShows(page: Int)
    case AiringToday(page: Int)
    case OnTheAirShows(page: Int)
    case TopRatedShows(page: Int)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .PopularShows(let page):
            return NetworkConstants.Network.Endpoints.popularShows+"&page=\(page)"
        case .AiringToday(let page):
            return NetworkConstants.Network.Endpoints.airingToday+"&page=\(page)"
        case .OnTheAirShows(let page):
            return NetworkConstants.Network.Endpoints.onTheAirShows+"&page=\(page)"
        case .TopRatedShows(let page):
            return NetworkConstants.Network.Endpoints.topRatedShows+"&page=\(page)"
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
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if method.rawValue != "GET" {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        urlRequest.allHTTPHeaderFields = header
        
        return urlRequest
    }
}
