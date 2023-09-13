//
//  CartTableViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/30/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTapAdd(sender: Any!) {
        if let quantity = self.quantityLabel.text {
            if var quanityNumber = Int(quantity) {
                quanityNumber += 1
                self.quantityLabel.text = "\(quanityNumber)"
            }
        }
    }
    
    @IBAction func onTapRemove(sender: Any!) {
        if let quantity = self.quantityLabel.text {
            if var quanityNumber = Int(quantity) {
                if quanityNumber - 1 > 0 {
                    quanityNumber -= 1
                    self.quantityLabel.text = "\(quanityNumber)"
                }
            }
        }
    }
}
