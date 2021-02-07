//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Illya Sirosh on 07.02.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = Assembly.shared.getNewsModule()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func show(article: Article) {
        let vc = Assembly.shared.getArticleModule(for: article)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
