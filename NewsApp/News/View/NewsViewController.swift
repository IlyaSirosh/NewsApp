//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Illya Sirosh on 06.02.2021.
//

import UIKit

protocol NewsView: AnyObject {
    func show(news: [Article])
}

class NewsViewController: UIViewController, NewsView, Coordinatable, Storyboarded {
    var articles: [Article] = []
    @IBOutlet weak var newsTableView: UITableView!
    
    var presenter: NewsPresenter?
    weak var coordinator: Coordinator?

    let cellID = String(describing: ArticleCell.self)
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID )
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        navigationItem.title = "News"
        
        presenter?.loadNews()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    func show(news: [Article]) {
        articles = news
        newsTableView.reloadData()
    }
}



extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        coordinator?.show(article: article)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ArticleCell
        cell.article = articles[indexPath.row]
        return cell
    }
}
