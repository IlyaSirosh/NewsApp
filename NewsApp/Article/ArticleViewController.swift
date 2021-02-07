//
//  ArticleViewController.swift
//  NewsApp
//
//  Created by Illya Sirosh on 07.02.2021.
//

import UIKit
import WebKit


class ArticleViewController: UIViewController, Coordinatable, Storyboarded, WKUIDelegate {
    var article: Article!
    weak var coordinator: Coordinator?
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        webView.scrollView.addSubview(refreshControl)
        webView.scrollView.bounces = true
        refreshControl.addTarget(self, action: #selector(refreshWebView(_:)), for: UIControl.Event.valueChanged)
        
        let myRequest = URLRequest(url: article.url)
        webView.load(myRequest)
        webView.uiDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(self.webView.estimatedProgress)
            self.progressView.setProgress(progress, animated: true)
            if progress >= 1.0 {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.progressView.isHidden = true
                }) { _ in
                    self.progressView.progress = 0
                    self.progressView.isHidden = false
                }
            }
        }
    }

    @objc
    func refreshWebView(_ sender: UIRefreshControl) {
        webView.reload()
        sender.endRefreshing()
    }
}
