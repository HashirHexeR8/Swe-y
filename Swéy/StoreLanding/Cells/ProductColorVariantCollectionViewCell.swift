//
//  ProductColorVariantCollectionViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 25/02/2025.
//

import UIKit

class ProductColorVariantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var variantColorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        variantColorView.cornerRadius = 30/2
        variantColorView.backgroundColor = .red
        variantColorView.borderWidth = 2
        variantColorView.borderColor = UIColor.systemGray6
    }
    
    func setupCell(color: UIColor) {
        variantColorView.backgroundColor = color
    }

}
