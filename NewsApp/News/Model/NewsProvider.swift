//
//  NewsProvider.swift
//  NewsApp
//
//  Created by Illya Sirosh on 06.02.2021.
//

import Foundation

class NewsProvider {
    private let networkService: NewsNetworkService
    private var currentPage: Int = 0
    private var pageSize: Int = 20
    private var totalNumberOfArticles: Int?
    private var news: [Article] = []
    
    init(networkService: NewsNetworkService) {
        self.networkService = networkService
    }
    
    func loadNews(completion: @escaping ([Article]) -> Void) {
        
        networkService.loadNews { [unowned self] result in
            
            switch result {
            case .success(let result):
                news.append(contentsOf: result.articles)
                totalNumberOfArticles = result.totalResults
                completion(result.articles)
            case .failure(_):
                completion([Article]())
            }
            

        }
    }
    
}
