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
    private var news: [[Article]] = []
    
    init(networkService: NewsNetworkService) {
        self.networkService = networkService
    }
    
    func loadNews(completion: @escaping ([Article]) -> Void) {
        currentPage = 0
        totalNumberOfArticles = nil
        load(completion: completion)
    }
    
    func loadNextNews(completion: @escaping ([Article]) -> Void) {
        guard canLoadNext else { return }
        currentPage += 1
        
        if news.count > currentPage && !news[currentPage].isEmpty {
            completion(news[currentPage])
        } else {
            load(completion: completion)
        }
        
    }
    func loadPrevNews(completion: @escaping ([Article]) -> Void) {
        guard canLoadPrev else { return }
        
        currentPage -= 1
        
        if !news[currentPage].isEmpty {
            completion(news[currentPage])
        } else {
            load(completion: completion)
        }
    }
    
    func reload(completion: @escaping ([Article]) -> Void) {
        load(completion: completion)
    }
    
    var canLoadNext: Bool {
        (currentPage + 1) * pageSize < (totalNumberOfArticles ?? 0)
    }
    
    var canLoadPrev: Bool {
        currentPage > 0
    }
    
    
    private func load(completion: @escaping ([Article]) -> Void) {
        let requestInfo = NewsRequest(
            page: currentPage + 1,
            country: "us",
            source: nil,
            category: nil)
        
        networkService.loadNews(requestInfo) { [unowned self] result in
            switch result {
            case .success(let result):
                saveNews(result.articles)
                totalNumberOfArticles = result.totalResults
                completion(result.articles)
            case .failure(_):
                completion([Article]())
            }
        }
        
    }
    
    private func saveNews(_ articles: [Article]) {
        news.append(articles)
    }
}
