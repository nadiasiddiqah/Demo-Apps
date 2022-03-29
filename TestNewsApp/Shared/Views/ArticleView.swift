//
//  ArticleView.swift
//  TestNewsApp (iOS)
//
//  Created by Nadia Siddiqah on 7/13/21.
//

import SwiftUI
import URLImage

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        HStack {
            
            if let imgUrl = article.image,
               let url = URL(string: imgUrl) {
                
                URLImage(url, identifier: article.id.uuidString) { error, _ in
                    PlaceholderImageView()
                } content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            } else {
                // Placeholder image if image fails to load
                PlaceholderImageView()
            }
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(article.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold, design: .default))
                Text(article.source ?? "N/A")
                    .foregroundColor(.gray)
                    .font(.footnote)
                Text(article.date!, style: .date)
                    .foregroundColor(.black)
                    .font(.footnote)
            })
        }
    }
}

struct PlaceholderImageView: View {
    
    var body: some View {
        Image(systemName: "photo-fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
    }
}
