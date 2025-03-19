//
//  ProductDetailCollectionViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/3/23.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    private var colors = [UIColor(hexString: "#0079FF", alpha: 1.0), UIColor(hexString: "#4FB7B9", alpha: 1.0), UIColor(hexString: "#FF00C7", alpha: 1.0), UIColor(hexString: "#FF9595", alpha: 1.0), UIColor(hexString: "#FFBA49", alpha: 1.0), UIColor(hexString: "#000000", alpha: 1.0)]
    
    private var sizes = ["US 5", "US 6", "US 7", "US 8", "US 9", "US 10", "US 11", "US 12", "US 13", "US 14"]

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.colorCollectionView.delegate = self
        self.colorCollectionView.dataSource = self
        self.sizeCollectionView.delegate = self
        self.sizeCollectionView.dataSource = self
        
        self.colorCollectionView.register(UINib(nibName: String(describing: ProductColorVariantCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(String(describing: ProductColorVariantCollectionViewCell.self)))
        
        self.sizeCollectionView.register(UINib(nibName: String(describing: ProductSizeVariantCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(String(describing: ProductSizeVariantCollectionViewCell.self)))
        
        
        //self.sizeCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: createNormalProductSection(sectionIndex: 0))
        
    }
    
    func createNormalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let sizeItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(50)))
        sizeItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: sizeItem, count: 5)
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 29 {
            return CGSize(width: 30, height: 30)
        }
        return CGSize(width: 80, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 29 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(String(describing: ProductColorVariantCollectionViewCell.self)), for: indexPath) as! ProductColorVariantCollectionViewCell
            cell.setupCell(color: colors[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(String(describing: ProductSizeVariantCollectionViewCell.self)), for: indexPath) as! ProductSizeVariantCollectionViewCell
            cell.setupCell(cellText: sizes[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 39 {
            return sizes.count
        }
        return colors.count
    }

}
