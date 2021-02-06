//
//  NewsData.swift
//  NewsApp
//
//  Created by Illya Sirosh on 05.02.2021.
//

import Foundation

struct NewsResultData: Decodable {
    let status: String
    let totalResults: Int
    let articles: [NewsData]
}

struct NewsData: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: String
    let content: String?
    
    
    struct Source: Decodable {
        let name: String
    }
}
