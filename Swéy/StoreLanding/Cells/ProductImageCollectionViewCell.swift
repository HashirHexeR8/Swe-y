//
//  ProductImageCollectionViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 5/14/23.
//

import UIKit

class ProductImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(imageName: String) {
        cellImageView.image = UIImage(named: imageName)
    }

}
