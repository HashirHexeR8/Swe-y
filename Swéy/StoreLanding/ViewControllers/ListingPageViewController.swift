//
//  ListingPageViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 5/14/23.
//

import UIKit

class ListingPageViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var sectionDataSource: [ListingPageProductSectionDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionDataSource = createDataSource()
        
        let nib = UINib(nibName: String(describing: ProductImageCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
        segmentedControl.addUnderlineForSelectedSegment()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        self.segmentedControl.changeUnderlinePosition()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.sectionDataSource[sectionIndex].sectionType {
            case .normalProductSection:
                return self.createNormalProductSection(sectionIndex: sectionIndex)
            case .verticalProductSection:
                return self.createVerticalProductSection(sectionIndex: sectionIndex)
            default:
                return self.createNormalProductSection()
            }
        }
        return layout
    }
    
    func createNormalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
        
        var products: [NSCollectionLayoutItem] = []
        
        for product in sectionDataSource[sectionIndex].products {
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(product.itemPriority), heightDimension: .fractionalHeight(1)))
            productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
            products.append(productItem)
        }
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(223))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: products)
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        return section
    }
    
    func createVerticalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
        var products: [NSCollectionLayoutItem] = []
        
        for product in sectionDataSource[sectionIndex].products {
            if product.itemType == .verticalItem {
                break
            }
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(product.itemPriority)))
            productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
            products.append(productItem)
        }
        
        let verticalProduct = sectionDataSource[sectionIndex].products.first { product in
            product.itemType == .verticalItem
        }
        
        if let verticalProduct = verticalProduct {
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(verticalProduct.itemPriority)))
            
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: products)
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(422))
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalGroup, productItem])
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            return section
            
        }
        else {
            
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1))
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: products)
            //Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            return section
        }
    }
    
    func createNormalProductSection() -> NSCollectionLayoutSection {
        let firstItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1)))
        let secondItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1)))
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(223))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [firstItem, secondItem])
        //Section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }

    
    func createDataSource() -> [ListingPageProductSectionDTO] {
        //Section 1
        let product1 = ListingPageProductDTO(itemImage: "s1p1", itemType: .horizontalGroupItem, itemPriority: 0.6)
        let product2 = ListingPageProductDTO(itemImage: "s1p2", itemType: .horizontalGroupItem, itemPriority: 0.4)
        let section1 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product1, product2])
        //Section 2
        let product3 = ListingPageProductDTO(itemImage: "s2p1", itemType: .horizontalGroupItem, itemPriority: 0.4)
        let product4 = ListingPageProductDTO(itemImage: "s2p2", itemType: .horizontalGroupItem, itemPriority: 0.6)
        let section2 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product3, product4])
        //Section 3
        let product5 = ListingPageProductDTO(itemImage: "s3p1", itemType: .horizontalGroupItem, itemPriority: 0.6)
        let product6 = ListingPageProductDTO(itemImage: "s3p2", itemType: .horizontalGroupItem, itemPriority: 0.4)
        let section3 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product5, product6])
        //Section 4
        let product7 = ListingPageProductDTO(itemImage: "s4p1", itemType: .verticalGroupItem, itemPriority: 0.35)
        let product8 = ListingPageProductDTO(itemImage: "s4p2", itemType: .verticalGroupItem, itemPriority: 0.65)
        let product9 = ListingPageProductDTO(itemImage: "s4p3", itemType: .verticalItem, itemPriority: 1)
        let section4 = ListingPageProductSectionDTO(sectionName: "p2", sectionType: .verticalProductSection, products: [product7, product8, product9])
        //Section 5
        let product10 = ListingPageProductDTO(itemImage: "s5p1", itemType: .horizontalGroupItem, itemPriority: 0.6)
        let product11 = ListingPageProductDTO(itemImage: "s5p2", itemType: .horizontalGroupItem, itemPriority: 0.4)
        let section5 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product10, product11])
        
        return [section1, section2, section3, section4, section5]
    }
    
    
}

extension ListingPageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionDataSource[section].products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductImageCollectionViewCell.self), for: indexPath) as! ProductImageCollectionViewCell
        cell.setupCell(imageName: sectionDataSource[indexPath.section].products[indexPath.row].itemImage)
        return cell
    }
}
