//
//  FilterCategoryCollectionViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/15/24.
//

import UIKit

class FilterCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.cornerRadius = 8.0
        // Initialization code
    }

}
