//
//  SizeTileFilterCollectionViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/4/23.
//

import UIKit

class SizeTileFilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sizeText: UILabel!
    @IBOutlet weak var sizeCountry: UILabel!
    
    var backgroundLayer = CAGradientLayer()
    var isFilterSelected: Bool = false {
        didSet {
            backgroundLayer.isHidden = !isFilterSelected
            if isFilterSelected {
                sizeText.textColor = UIColor.white
                sizeCountry.textColor = UIColor.white
            }
            else {
                sizeText.textColor = UIColor.black
                sizeCountry.textColor = UIColor.black
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.borderColor = UIColor(hexString: "#0079FF").withAlphaComponent(0.5)
        self.contentView.borderWidth = 1.0
        self.contentView.cornerRadius = 12.0
        gradientLayer()
        // Initialization code
    }
    
    func gradientLayer() {
        
        backgroundLayer.colors = [
        UIColor(red: 0.306, green: 0.663, blue: 1, alpha: 1).cgColor,
        UIColor(red: 0.039, green: 0.498, blue: 1, alpha: 1).cgColor]
        backgroundLayer.locations = [0, 1]
        backgroundLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        backgroundLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        backgroundLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.5, b: 0.86, c: -0.86, d: 0.93, tx: 0.43, ty: -0.11))
        backgroundLayer.bounds = self.contentView.bounds.insetBy(dx: -0.5 * self.contentView.bounds.size.width, dy: -0.5 * self.contentView.bounds.size.height)
        backgroundLayer.position = self.contentView.center
        backgroundLayer.isHidden = true
        self.contentView.layer.insertSublayer(backgroundLayer, at: 0)        
    }

}
