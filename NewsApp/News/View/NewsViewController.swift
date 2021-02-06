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

class NewsViewController: UIViewController, NewsView {
    var articles: [Article] = []
    var presenter: NewsPresenter!
    var newsTableView: UITableView!
    let cellID = String(describing: ArticleCell.self)
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newsTableView = UITableView()
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        newsTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID )
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        
        presenter.loadNews()
    }
    

    func show(news: [Article]) {
        print(" show data \(news.count ) items")
        articles = news
        newsTableView.reloadData()
    }
}

//

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("do something")
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
