//
//  ListingDetailPageViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/5/23.
//

import UIKit

class ListingDetailPageViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var similarItemsCollectionView: CustomCollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var productPriceContainer: UIView!
    @IBOutlet weak var productInfoContainer: UIView!
    @IBOutlet weak var sweyCartButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var productPriceButton: UIStackView!
    @IBOutlet weak var deliveryPriceButton: UIButton!
    
    private var sectionDataSource: [ListingPageProductSectionDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: ProductImageCollectionViewCell.self), bundle: nil)
        productImagesCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        similarItemsCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        let productDetailNib = UINib(nibName: String(describing: ProductDetailCollectionViewCell.self), bundle: nil)
        similarItemsCollectionView.register(productDetailNib, forCellWithReuseIdentifier: String(describing: ProductDetailCollectionViewCell.self))
        
        self.sectionDataSource = createDataSource()
        
        self.similarItemsCollectionView.dataSource = self
        self.similarItemsCollectionView.delegate = self
        self.productImagesCollectionView.dataSource = self
        self.productImagesCollectionView.delegate = self
        
        self.similarItemsCollectionView.collectionViewLayout = createCompositionalLayout()
        self.productImagesCollectionView.collectionViewLayout = createCompositionalLayoutForFullProductImages()
        
        self.segmentedControl.addUnderlineForSelectedSegment()
        
        self.sweyCartButton.clipsToBounds = false
        self.sweyCartButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.sweyCartButton.layer.shadowOpacity = 0.5
        self.sweyCartButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.sweyCartButton.layer.shadowRadius = 10
        self.sweyCartButton.layer.masksToBounds = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onbackButtonViewTap))
        backButtonView.addGestureRecognizer(tapGesture)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight(_: )))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.similarItemsCollectionView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft(_: )))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.similarItemsCollectionView.addGestureRecognizer(swipeLeft)
                
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapProductPrice))
        productPriceButton.addGestureRecognizer(viewTapGesture)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func scrollToTop() {
        let topOffset = CGPoint(x: 0, y: 0)
        UIView.animate(withDuration: 1) {
            self.scrollView.setContentOffset(topOffset, animated: true)
        }
    }
    
    func updateCollectionViewHeight() {
        self.similarItemsCollectionView.layoutIfNeeded()
        self.similarItemsCollectionView.constraints.forEach { constraint in
            if constraint.identifier == "similarProductsCollectionViewHeightConstraint" {
                constraint.constant = self.similarItemsCollectionView.contentSize.height
            }
        }
    }
    
    @objc func swipedRight(_ sender: UISwipeGestureRecognizer) {
        if self.segmentedControl.selectedSegmentIndex != 0 {
            self.segmentedControl.selectedSegmentIndex -= 1
            self.onSegmentValueChange(self.segmentedControl)
        }
    }

    @objc func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        if self.segmentedControl.selectedSegmentIndex != 1 {
            self.segmentedControl.selectedSegmentIndex += 1
            self.onSegmentValueChange(self.segmentedControl)
        }
    }
    
    @objc func onTapProductPrice(_ sender: Any) {
        self.deliveryPriceButton.isHidden = false
    }
    
    @objc func onbackButtonViewTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSegmentValueChange(_ sender: Any!) {
        self.segmentedControl.changeUnderlinePosition()
    
        self.similarItemsCollectionView.reloadData()
        updateCollectionViewHeight()
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
            self.scrollToTop()
        }
        productPriceContainer.isHidden = self.segmentedControl.selectedSegmentIndex != 0
    }
    
    @IBAction func onChatButtonTap (_ sender: Any!) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ChatViewController.self)) as? ChatViewController
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true)
    }
    
    @IBAction func onBackButtonTap(_ sender: Any!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSweyCartButton(_ sender: Any!) {
        sweyCartButton.isSelected = !sweyCartButton.isSelected
    }
    
    @IBAction func onCartButton(_ sender: Any!) {
        cartButton.isSelected = !cartButton.isSelected
    }
    
    func createCompositionalLayoutForFullProductImages() -> UICollectionViewCompositionalLayout {
        var products: [NSCollectionLayoutItem] = []
        
        let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
        products.append(productItem)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: products)
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            if self.segmentedControl.selectedSegmentIndex == 0 {
                return self.createProductDetailSection()
            }
            else {
                switch self.sectionDataSource[sectionIndex].sectionType {
                case .normalProductSection:
                    return self.createNormalProductSection(sectionIndex: sectionIndex)
                case .verticalProductSection:
                    return self.createVerticalProductSection(sectionIndex: sectionIndex)
                default:
                    return self.createNormalProductSection()
                }
            }
            
            
        }
        return layout
    }
    
    func createProductDetailSection() -> NSCollectionLayoutSection {
        
        var products: [NSCollectionLayoutItem] = []
        
        let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        productItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        products.append(productItem)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: products)
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
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
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.segmentedControl.changeBackgroundForAppearanceSwitch()
    }

}

extension ListingDetailPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionView.tag == 2 ? (self.segmentedControl?.selectedSegmentIndex == 1 ? sectionDataSource.count : 1) : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 2 ? (self.segmentedControl?.selectedSegmentIndex == 1 ? sectionDataSource[section].products.count : 1) : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2 {
            if self.segmentedControl.selectedSegmentIndex == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductDetailCollectionViewCell.self), for: indexPath) as! ProductDetailCollectionViewCell
                return cell
            }
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductImageCollectionViewCell.self), for: indexPath) as! ProductImageCollectionViewCell
                cell.setupCell(imageName: sectionDataSource[indexPath.section].products[indexPath.row].itemImage)
                return cell
            }
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductImageCollectionViewCell.self), for: indexPath) as! ProductImageCollectionViewCell
            if indexPath.row == 0 {
                cell.setupCell(imageName: "productDetailFullImage")
            }
            else {
                cell.setupCell(imageName: "productDetailNormal")
            }
            return cell
        }
    }
    
}
