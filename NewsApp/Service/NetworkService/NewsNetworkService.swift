//
//  NewsService.swift
//  NewsApp
//
//  Created by Illya Sirosh on 05.02.2021.
//

import Foundation
import Alamofire

protocol NewsNetworkService {
    func loadNews(page: Int, completion: @escaping (Result<NewsResult, Error>) -> Void)
}

class NewsAPINetworkService: NewsNetworkService {
    private let baseURLString = "https://newsapi.org/v2"
    private let apiKey = "e7809f321dc7413391b1b285892715ac"

    
    func loadNews(page: Int, completion: @escaping (Result<NewsResult, Error>) -> Void) {
        let url = urlString(for: "everything")
        
        var params: [String: String] = [:]
        params["apiKey"] = apiKey
        params["page"] = String(page)
        params["q"] = "election"
        
        AF.request(url, method: .get, parameters: params)
            .responseData { (response) in
                do {
                    let result = try self.handleNewsResponse(response)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    func handleNewsResponse(_ response: DataResponse<Data, AFError>) throws -> NewsResult {
        switch response.result {
        case .success(let data):
            let result = try JSONDecoder().decode(NewsResultData.self, from: data)
            return Mapper.map(result)
        case .failure(let error):
            throw error
        }
    }
    
    
    private func urlString(for path: String) -> String {
        "\(baseURLString)/\(path)"
    }
}
