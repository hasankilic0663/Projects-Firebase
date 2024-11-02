//
//  MovieTableViewCell.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 30.10.2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier: String = "MovieTableViewCell"

    @IBOutlet weak var customImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
}
