//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Illya Sirosh on 07.02.2021.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    var article: Article! {
        didSet {
            update()
        }
    }
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update() {
        sourceLabel.text = article.source
        authorLabel.text = article.author
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        if let url = article.urlToImage {
            articleImageView.kf.setImage(with: url, options: [       .cacheOriginalImage,
                .transition(.fade(0.25))
            ])
        } else {
            articleImageView.image = nil
        }
        
        
    }
    
}
