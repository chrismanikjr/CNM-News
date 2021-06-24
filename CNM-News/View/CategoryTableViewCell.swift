//
//  CategoryTableViewCell.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/24/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!{
        didSet{
            categoryImage.layer.masksToBounds = true
            categoryImage.clipsToBounds = true
            categoryImage.layer.cornerRadius = 10.0
            categoryImage.contentMode = .scaleAspectFill
            categoryImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
