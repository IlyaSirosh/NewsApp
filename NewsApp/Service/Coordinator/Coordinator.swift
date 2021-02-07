//
//  Coordinator.swift
//  NewsApp
//
//  Created by Illya Sirosh on 07.02.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController {get set}
    
    func start()
    
    func show(article: Article)
}
