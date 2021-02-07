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
    func loadNextNews()
    func loadPrevNews()
    func reloadNews()
}

class NewsPresenterImpl: NewsPresenter {
    let model: NewsProvider
    weak var view: NewsView?
    
    init(model: NewsProvider, view: NewsView) {
        self.model = model
        self.view = view
    }
    
    func loadNews() {
        disablePagination()
        model.loadNews { [unowned self] news in
            updateView(with: news)
        }
    }
    
    func loadNextNews() {
        disablePagination()
        model.loadNextNews { [unowned self] news in
            updateView(with: news)
        }
    }
    
    func loadPrevNews() {
        disablePagination()
        model.loadPrevNews { [unowned self] news in
            updateView(with: news)
        }
    }
    
    func reloadNews() {
        disablePagination()
        model.loadPrevNews { [unowned self] news in
            updateView(with: news)
        }
    }
    
    private func updateView(with news: [Article]) {
        view?.show(news: news)
        view?.setPagination(prev: model.canLoadPrev, next: model.canLoadNext)
    }
    
    private func disablePagination(){
        view?.setPagination(prev: false, next: false)
    }
}
