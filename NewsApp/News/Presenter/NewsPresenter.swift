//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Illya Sirosh on 06.02.2021.
//

import Foundation

protocol NewsPresenter {
    var view: NewsView? {get set}
    func loadNews()
}

class NewsPresenterImpl: NewsPresenter {
    let model: NewsProvider
    weak var view: NewsView?
    
    init(model: NewsProvider, view: NewsView) {
        self.model = model
        self.view = view
    }
    
    func loadNews() {
        model.loadNews { [unowned self] news in
            view?.show(news: news)
        }
    }
}
