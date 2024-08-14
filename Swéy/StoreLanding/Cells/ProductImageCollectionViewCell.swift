//
//  ProductImageCollectionViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 5/14/23.
//

import UIKit

class ProductImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var productCategoryHeadingTitle: UILabel!
    @IBOutlet weak var productCategoryDescription: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPriceInfoContainer: UIView!
    @IBOutlet weak var shopCategoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(imageName: String) {
        cellImageView.image = UIImage(named: imageName)
    }

}
