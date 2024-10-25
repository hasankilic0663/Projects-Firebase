//
//  CryptoTableViewCell.swift
//  CryptoCrazyRxMVVM
//
//  Created by Hasan Hüseyin Kılıç on 23.10.2024.
//

import UIKit
import RxSwift
import RxCocoa
class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var item : Crypto! {
        didSet {
            nameLabel.text = item.currency
            priceLabel.text = item.price
        }
    }

}
