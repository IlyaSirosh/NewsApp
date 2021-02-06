//
//  News.swift
//  NewsApp
//
//  Created by Illya Sirosh on 05.02.2021.
//

import Foundation

struct NewsResult{
    let totalResults: Int
    let articles: [Article]
}

struct Article {
    let source: String
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: Date
    let content: String?
}

