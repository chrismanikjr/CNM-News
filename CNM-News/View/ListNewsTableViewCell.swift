//
//  ListNewsTableViewCell.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/23/21.
//

import UIKit

class ListNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!{
        didSet{
            newsImage.layer.masksToBounds = true
            newsImage.clipsToBounds = true
            newsImage.layer.cornerRadius = 5.0
            newsImage.contentMode = .scaleAspectFill
            newsImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(news: ArticleModel){
        newsImage.downloaded(from: news.imageURL)
        titleLabel.text = news.title
        let dateString = changeDateString(dateValue: news.publishedAt)
        dateLabel.text = dateString
    }
    
    func changeDateString(dateValue: String) -> String{
        let dateString = dateValue.replacingOccurrences(of: "T", with: " ", options: NSString.CompareOptions.literal, range: nil)
        return dateString.replacingOccurrences(of: "Z", with: "", options: NSString.CompareOptions.literal, range: nil)
    }
    
    

}
