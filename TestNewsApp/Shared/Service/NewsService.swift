//
//  NewsService.swift
//  TestNewsApp (iOS)
//
//  Created by Nadia Siddiqah on 7/13/21.
//

import Foundation
import Combine          // Combine = lets you listen to changes from when you call the API

// Promote depedency injection (make this class testable)
// Contains function that triggers the request -> returns publisher
// In view model, listen to event that it publishes

protocol NewsService {
    // AnyPublisher = lets you subscribe + listen to event that we want to publish
    // NewsResponse = success / APIError = erro
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> 
}

struct NewsServiceImpl: NewsService {
    
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
        
        // URLSession = used to send API requests
        return URLSession
            .shared                                                                 // access singeton that URLSession offers
            .dataTaskPublisher(for: endpoint.urlRequest)                            // publishes data when task is complete
            .receive(on: DispatchQueue.main)                                        // receives response from publisher on main thread (to prevent UI from being out of date / crashing)
            .mapError { _ in APIError.unknown }                                     // map any API error using APIError.unknown -> so publisher can terminate
            .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> in    // flatten data from API / response from publisher
                 
                // Check if response is okay
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                // Check if response is specific code, else show Fail object of APIError.errorCode
                if (200...299).contains(response.statusCode) {
                    
                    // Decode date string into Date object
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    // Just = publisher that emits output to each subscriber just once + then finishes
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                    
                    
                    
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()                                                  // convert data from API into generic publisher that subscribed/listened to
    }
    
}

