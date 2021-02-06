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
    
    func getNewsModule() -> UIViewController {
        let networkService = NewsAPINetworkService()
        let model = NewsProvider(networkService: networkService)
        let view = NewsViewController()
        let presenter = NewsPresenterImpl(model: model, view: view)
        view.presenter = presenter
        return view
    }
}
