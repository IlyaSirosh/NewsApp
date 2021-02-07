//
//  ArticleViewController.swift
//  NewsApp
//
//  Created by Illya Sirosh on 07.02.2021.
//

import UIKit
import WebKit


class ArticleViewController: UIViewController, Coordinatable, WKUIDelegate {
    var article: Article!
    weak var coordinator: Coordinator?
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: article.url)
        webView.load(myRequest)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        view.backgroundColor = .white
    }

}
