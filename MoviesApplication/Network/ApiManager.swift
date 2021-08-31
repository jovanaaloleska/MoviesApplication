//
//  ApiManager.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/20/21.
//

import Foundation
import Alamofire

typealias completionHandler = ((_ success: Bool, _ responseData: [String:Any]?, _ statusCode: Int?) ->())

class ApiManager {
    
    static let sharedInstance = ApiManager()
    
    private func executeRequest (request: URLRequestConvertible, completion: @escaping completionHandler) {
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = value as? [String:Any]
                if let response = response.response{
                    let statusCode = response.statusCode
                    if statusCode == 200 {
                        completion(true, json, statusCode)
                    } else {
                        completion(false, nil, statusCode)
                    }
                    
                }
            case .failure(let error):
                if let response = response.response {
                    let statusCode = response.statusCode
                    completion(false, nil, statusCode)
                } else {
                    completion(false, nil, nil)
                }
                
            }
        }
    }
    
    func getPopularShows(page: Int, completion: @escaping completionHandler) {
        executeRequest(request: Router.PopularShows(page: page), completion: completion)
    }
    
    func getAiringToday(page: Int, completion: @escaping completionHandler) {
        executeRequest(request: Router.AiringToday(page: page), completion: completion)
    }
    
    func getOnTheAirShows(page: Int, completion: @escaping completionHandler) {
        executeRequest(request: Router.OnTheAirShows(page: page), completion: completion)
    }
    
    func getTopRatedShows(page: Int, completion: @escaping completionHandler) {
        executeRequest(request: Router.TopRatedShows(page: page), completion: completion)
    }
    
}
