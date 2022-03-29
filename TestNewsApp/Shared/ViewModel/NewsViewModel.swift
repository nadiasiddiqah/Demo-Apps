//
//  NewsViewModel.swift
//  TestNewsApp (iOS)
//
//  Created by Nadia Siddiqah on 7/13/21.
//

import Foundation
import Combine

protocol NewsViewModel {
    func getArticles()
}

class NewsViewModelImpl: ObservableObject, NewsViewModel {
    
    // Dependency injection of NewsService object
    // Private object = only available in the class
    private let service: NewsService
    
    // Private set = protect within class + access it from outside the class
    private(set) var articles = [Article]()                           // Holds all articles
    
    private var cancellables = Set<AnyCancellable>()                  // Collection of cancellables
    
    // @Published = listen to value anytime it changes
    @Published private(set) var state: ResultState = .loading         // Current status of UI
    
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getNews)
            // Listen to completion - whether success/failure + listen to when its finished publishing
            .sink { result in
                switch result {
                case .finished:
                    // Send back articles
                    self.state = .success(content: self.articles)
                    break
                case .failure(let error):
                    // Send back error
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { response in
                self.articles = response.articles
            }
        
        // Insert cancellable into cancellables set so its not erased + gets saved in memory
        self.cancellables.insert(cancellable)
    }
}
