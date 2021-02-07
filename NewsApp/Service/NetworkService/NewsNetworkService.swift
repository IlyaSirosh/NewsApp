//
//  NewsService.swift
//  NewsApp
//
//  Created by Illya Sirosh on 05.02.2021.
//

import Foundation
import Alamofire

protocol NewsNetworkService {
    func loadNews(_ info: NewsRequest, completion: @escaping (Result<NewsResult, Error>) -> Void)
}

class NewsAPINetworkService: NewsNetworkService {
    private let baseURLString = "https://newsapi.org/v2"
    private let apiKey = "e7809f321dc7413391b1b285892715ac"

    
    func loadNews(_ info: NewsRequest, completion: @escaping (Result<NewsResult, Error>) -> Void) {
        let url = urlString(for: "top-headlines")
        
        let queryParams = parameters(info)
        print(url)
        
        AF.request(url, method: .get, parameters: queryParams)
            .responseData { (response) in
                do {
                    let result = try self.handleNewsResponse(response)
                    completion(.success(result))
                } catch {
                    print(error)
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
    
    private func parameters(_ info: NewsRequest) -> [String: String] {
        var params: [String: String] = [:]
        params["apiKey"] = apiKey
        params["page"] = String(info.page)
        
        if let source = info.source {
            params["source"] = source
        } else {
            if let country = info.country {
                params["country"] = country
            }
            if let category = info.category {
                params["category"] = category
            }
        }

        
        return params
    }
    
    private func urlString(for path: String) -> String {
        "\(baseURLString)/\(path)"
    }
}
