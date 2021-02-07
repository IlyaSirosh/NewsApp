//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Illya Sirosh on 06.02.2021.
//

import UIKit

protocol NewsView: AnyObject {
    func show(news: [Article])
    func setPagination(prev: Bool, next: Bool)
}

class NewsViewController: UIViewController, NewsView, Coordinatable, Storyboarded {
    var articles: [Article] = []
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    
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
    
    @IBAction func previousNewsTapped(_ sender: UIButton) {
        presenter?.loadPrevNews()
    }

    @IBAction func nextNewsTapped(_ sender: UIButton) {
        presenter?.loadNextNews()
    }
    
    
    
    func show(news: [Article]) {
        articles = news
        newsTableView.reloadData()
        newsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    func setPagination(prev: Bool, next: Bool) {
        prevButton.isHidden = !prev
        nextButton.isHidden = !next
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
