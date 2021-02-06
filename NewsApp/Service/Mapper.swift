//
//  Mapper.swift
//  NewsApp
//
//  Created by Illya Sirosh on 06.02.2021.
//

import Foundation



struct Mapper {
    
    
    static func map(_ data: NewsResultData) -> NewsResult {
        NewsResult(
            totalResults: data.totalResults,
            articles: data.articles.map { newsData -> Article in
                map(newsData)
            }
        )
    }
    
    
    static func map(_ data: NewsData) -> Article {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: data.publishedAt) ?? Date()
        
        return Article(
            source: data.source.name,
            author: data.author ?? "anonymous",
            title: data.title,
            description: data.description,
            url: data.url,
            urlToImage: data.urlToImage,
            publishedAt: date,
            content: data.content
        )
    }

    
}
