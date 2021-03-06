//
//  Assembly.swift
//  NewsApp
//
//  Created by Illya Sirosh on 06.02.2021.
//

import UIKit

class Assembly {
    
    public static let shared = Assembly()
    
    private init() {}
    
    func getNewsModule() -> Coordinatable {
        let networkService = NewsAPINetworkService()
        let model = NewsProvider(networkService: networkService)
        let view = NewsViewController.instantiate()
        let presenter = NewsPresenterImpl(model: model, view: view)
        view.presenter = presenter
        return view
    }
    
    func getArticleModule(for article: Article) -> Coordinatable {
        let vc = ArticleViewController.instantiate()
        vc.article = article
        return vc
    }
}
