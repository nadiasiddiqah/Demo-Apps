//
//  HomeView.swift
//  TestNewsApp (iOS)
//
//  Created by Nadia Siddiqah on 7/13/21.
//

import SwiftUI

struct HomeView: View {
    
    // StateObject = when app leaves current state, its maintained in memory + to avoid losing current object
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    // Access system's capacity of opening links
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        Group {
            
            // Check current state
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                // Error Handler = retry button pressed
                ErrorView(error: error,
                          handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List(articles) { item in
                        ArticleView(article: item)
                            .onTapGesture {
                                load(url: item.url)
                            }
                    }
                    .navigationTitle(Text("News"))
                }
            }
            
        }.onAppear(perform: viewModel.getArticles)
    }
    
    func load(url: String?) {
        
        guard let link = url,
              let url = URL(string: link) else { return }
            
        openURL(url)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
