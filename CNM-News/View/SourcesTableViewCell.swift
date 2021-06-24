//
//  SourcesTableViewCell.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/24/21.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureSource(source: SourceModel){
        nameLabel.text = source.name
        descLabel.text = source.desc
    }
    
}
