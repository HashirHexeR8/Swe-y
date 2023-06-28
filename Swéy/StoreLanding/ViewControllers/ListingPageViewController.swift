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
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var guidView: UIView!
    @IBOutlet weak var guidTile1: UIView!
    @IBOutlet weak var guidTile2: UIView!
    @IBOutlet weak var guidTile3: UIView!
    @IBOutlet weak var filterSearchBackgroundView: UIView!
    @IBOutlet weak var cartCountButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    
    private var guideTapCount: Int = 0
    private var blurView: UIVisualEffectView?
    ///Offset to calculate if there's any change in scroll of tableview
    private var lastContentOffset: CGFloat = 0
    ///Flag to show and hide the topFilterView
    private var isFilterViewHidden: Bool = false {
        didSet {
            if isFilterViewHidden {
                for constraint in segmentedControl.constraints {
                    if constraint.identifier == "segmentHeightConstraint" {
                        constraint.constant = 0
                    }
                }
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
                
            }
            else {
                //blurView?.effect = .none
                for constraint in segmentedControl.constraints {
                    if constraint.identifier == "segmentHeightConstraint" {
                        constraint.constant = 45
                    }
                }
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
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
        
        self.guidView.isUserInteractionEnabled = true
        self.guidView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onGuidViewTap)))
        
        self.cartCountButton.clipsToBounds = false
        self.cartCountButton.layer.shadowColor = UIColor.black.cgColor
        self.cartCountButton.layer.shadowOpacity = 0.5
        self.cartCountButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.cartCountButton.layer.shadowRadius = 2
        self.cartCountButton.layer.masksToBounds = false
        
        self.cartButton.clipsToBounds = false
        self.cartButton.layer.shadowColor = UIColor.black.cgColor
        self.cartButton.layer.shadowOpacity = 0.5
        self.cartButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.cartButton.layer.shadowRadius = 2
        self.cartButton.layer.masksToBounds = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFilterButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: FIlterMainViewController.self)) as? FIlterMainViewController
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true)
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        self.segmentedControl.changeUnderlinePosition()
    }
    
    @objc func onGuidViewTap(_ sender: Any) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            
            switch self.guideTapCount {
            case 0:
                self.guidTile1.isHidden = true
                self.guidTile2.isHidden = false
            case 1:
                self.guidTile2.isHidden = true
                self.guidTile3.isHidden = false
            case 2:
                self.guidTile3.isHidden = true
                self.guidView.isHidden = true
            default:
                self.guidView.isHidden = true
            }
        })
        self.guideTapCount += 1
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.sectionDataSource[sectionIndex].sectionType {
            case .normalProductSection:
                return self.createNormalProductSection(sectionIndex: sectionIndex)
            case .verticalProductSection:
                return self.createVerticalProductSection(sectionIndex: sectionIndex)
            case .horizontalProductSection:
                return self.createHorizontalProductSection(sectionIndex: sectionIndex)
            default:
                return self.createNormalProductSection()
            }
        }
        return layout
    }
    
    func createHorizontalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
        
        var products: [NSCollectionLayoutItem] = []
        var verticalProducts: [NSCollectionLayoutItem] = []
        
        for product in sectionDataSource[sectionIndex].products.filter({ productItem in productItem.itemType == .verticalGroupItem}) {
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(175), heightDimension: .fractionalHeight(product.itemPriority)))
            productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
            products.append(productItem)
        }
        
        for product in sectionDataSource[sectionIndex].products.filter({ productItem in productItem.itemType == .verticalItem}) {
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(191), heightDimension: .fractionalHeight(1)))
            productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
            verticalProducts.append(productItem)
        }
        
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(175), heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: products)
        let verticalProductsGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(354))
        let verticalProductsGroup = NSCollectionLayoutGroup.horizontal(layoutSize: verticalProductsGroupSize, subitems: verticalProducts)
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(354))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalGroup, verticalProducts[0], verticalProducts[0], verticalProducts[0]])
        //Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 8)
        section.orthogonalScrollingBehavior = .continuous
        return section
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
        let horizontalProduct1 = ListingPageProductDTO(itemImage: "h1p1", itemType: .verticalGroupItem, itemPriority: 0.5)
        let horizontalProduct2 = ListingPageProductDTO(itemImage: "h1p2", itemType: .verticalGroupItem, itemPriority: 0.5)
        let horizontalProduct3 = ListingPageProductDTO(itemImage: "h1p3", itemType: .verticalItem, itemPriority: 0.7)
        let horizontalProduct4 = ListingPageProductDTO(itemImage: "h1p4", itemType: .verticalItem, itemPriority: 0.8)
        let horizontalProduct5 = ListingPageProductDTO(itemImage: "h1p5", itemType: .verticalItem, itemPriority: 0.9)
        let horizontalSection1 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .horizontalProductSection, products: [horizontalProduct1, horizontalProduct2, horizontalProduct3, horizontalProduct4, horizontalProduct5])
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
        
        return [horizontalSection1, section1, section2, section3, section4, section5]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.segmentedControl.addUnderlineForSelectedSegment()
    }
    
}

extension ListingPageViewController: UICollectionViewDataSource {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            self.lastContentOffset = scrollView.contentOffset.y
            let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
            if translation.y > 0 {
            }
            else {
                self.isFilterViewHidden = true
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            if self.lastContentOffset < scrollView.contentOffset.y {
                // did move up
            } else if self.lastContentOffset > scrollView.contentOffset.y {
                // did move down
                self.isFilterViewHidden = false
            }
            
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
        }
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ListingDetailPageViewController.self)) as? ListingDetailPageViewController
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                if let view = self.viewByClassName(view: window, className: "_UICutoutShadowView") {
                    view.isHidden = true
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: {
            // Create a preview view controller and return it
            if let indexPath = indexPaths.first {
                return self.previewProv(imageName: self.sectionDataSource[indexPath.section].products[indexPath.row].itemImage)
            }
            return self.previewProv(imageName: "s1p1")
            
        })
    }
    
    func previewProv(imageName: String) -> UIViewController? {
        let fontPreviewVC = self.storyboard?.instantiateViewController(
            withIdentifier: "ProductPreviewViewController") as! ProductPreviewViewController
        fontPreviewVC.setProductImage(imageName: imageName)
        fontPreviewVC.modalPresentationStyle = .fullScreen
        return fontPreviewVC
    }
    
    func viewByClassName(view: UIView, className: String) -> UIView? {
        let name = NSStringFromClass(type(of: view))
        if name == className {
            return view
        }
        else {
            for subview in view.subviews {
                if let view = viewByClassName(view: subview, className: className) {
                    return view
                }
            }
        }
        return nil
    }
}
