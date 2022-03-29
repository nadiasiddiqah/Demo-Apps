//
//  NewsResponse.swift
//  TestNewsApp (iOS)
//
//  Created by Nadia Siddiqah on 7/13/21.
//

import Foundation

struct NewsResponse: Codable {
    
    let articles: [Article]
}

// MARK: - Article

// Need to use Identifiable bc each Article is shown in a list + needs a unique identifier
struct Article: Codable, Identifiable {
    let id = UUID()
    let author: String?
    let url: String?
    let source, title: String?
    let articleDescription: String?
    let image: String?
    let date: Date?

    // For API's "description" key (reserved Swift word) -> QuickType generated new key called "articleDescription"
    enum CodingKeys: String, CodingKey {
        case author, url, source, title
        case articleDescription = "description"
        case image, date
    }
}

extension Article {
    
    static var dummyData: Article {
        .init(author: "Mirna Alsharif, CNN",
              url: "https://www.cnn.com/2021/07/13/us/baltimore-mall-shooting-officers-injured/index.html",
              source: "CNN",
              title: "2 officers injured and homicide suspect dead in shooting near Baltimore mall, police say - CNN ",
              articleDescription: "Two law enforcement officers were injured following reports of a shooting in Security Square Mall in Baltimore, Maryland, according to a tweet from the Baltimore County Police Department.",
              image: "https://cdn.cnn.com/cnnnext/dam/assets/150325082132-social-gfx-breaking-news-super-tease.jpg",
              date: Date())
    }
}

