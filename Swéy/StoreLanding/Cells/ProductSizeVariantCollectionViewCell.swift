//
//  ProductSizeVariantCollectionViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 25/02/2025.
//

import UIKit

class ProductSizeVariantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sizeItemContainerView: UIView!
    @IBOutlet weak var sizeItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sizeItemContainerView.cornerRadius = 15
        sizeItemContainerView.borderWidth = 1
        sizeItemContainerView.borderColor = UIColor.black
    }
    
    func setupCell(cellText: String) {
        sizeItemLabel.text = cellText
    }

}
