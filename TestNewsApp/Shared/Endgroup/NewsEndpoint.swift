//
//  NewsEndpoint.swift
//  TestNewsApp (iOS)
//
//  Created by Nadia Siddiqah on 7/13/21.
//

import Foundation

// Reusable APIBuilder to "get" these properties
protocol APIBuilder {
    var urlRequest: URLRequest { get }          // URL request that is sent using our code
    var baseUrl: URL { get }                    // Base URL for the API
    var path: String { get }                    // Path to retrieve the resources
}

// Define API - has one endpoint/case = getNews
enum NewsAPI {
    case getNews
}

// Build out API + use extension on APIBuilder protocol -> creates defined network layer
extension NewsAPI: APIBuilder {
    
    
    var baseUrl: URL {
        // Has one endpoint/case
        switch self {
        case .getNews:
            return URL(string: "https://api.lil.software")!
        }
    }
    
    var path: String {
        return "/news"
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    }
}
