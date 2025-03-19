//
//  ListingPageViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 5/14/23.
//

import UIKit

class ListingPageViewController: UIViewController, UICollectionViewDelegate {
    
    required init?(coder: NSCoder) {
        fatalError("Coder not allowed to be called from storyboard.")
    }
    
    required init?(coder: NSCoder, scrollDelegate: ScrollDirectionDelegate) {
        scrollDirectionDelegate = scrollDelegate
        super.init(coder: coder)
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartCountButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    
    ///Offset to calculate if there's any change in scroll of tableview
    private var lastContentOffset: CGFloat = 0
    
    lazy var blurredView: UIView = {
        return UIView()
    } ()
    
    private var scrollDirectionDelegate: ScrollDirectionDelegate?
    
    
    ///Flag to show and hide the topFilterView
    private var isFilterViewHidden: Bool = false {
        didSet {
            
        }
    }
    
    var sectionDataSource: [ListingPageProductSectionDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.keyboardDismissMode = .onDrag
        
        sectionDataSource = createDataSource()
        
        let nib = UINib(nibName: String(describing: ProductImageCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = PinterestLayout()
        collectionView.collectionViewLayout = createCompositionalLayout()

        
        //collectionView.collectionViewLayout = createCompositionalLayout()
        
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
        
    }
    
    @IBAction func onCartButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SweyCart", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: CartViewController.self)) as? CartViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.sectionDataSource[sectionIndex].sectionType {
            case .normalProductSection:
                return self.createNormalProductSection(sectionIndex: sectionIndex, layoutEnvironment: layoutEnvironment)
            case .verticalProductSection:
                return self.createVerticalProductSection(sectionIndex: sectionIndex)
            case .categoriesSection:
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
        
        for _ in sectionDataSource[sectionIndex].products {
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .fractionalHeight(1)))
            productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
            products.append(productItem)
        }
        
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.68))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: products)
        //Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 95, leading: 2, bottom: 10, trailing: 10)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    private func createNormalProductSection(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let spacing: CGFloat = 2
        let containerWidth = layoutEnvironment.container.effectiveContentSize.width
        
        // Get current section data
        let sectionData = sectionDataSource[sectionIndex]
        
        switch sectionData.sectionType {
        case .verticalProductSection:
            // Create item for vertical group (half width)
            let verticalItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .estimated(200)
                )
            )
            
            verticalItem.contentInsets = NSDirectionalEdgeInsets(
                top: spacing/2,
                leading: 5,
                bottom: spacing/2,
                trailing: 5
            )
            
            // Create group with two vertical items
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .estimated(400)
                ),
                subitem: verticalItem,
                count: 2
            )
            
            // Create horizontal group to place two vertical groups side by side
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(400)
                ),
                subitems: [verticalGroup, verticalGroup]
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: spacing/2,
                leading: 5,
                bottom: spacing/2,
                trailing: 5
            )
            return section
            
        case .horizontalProductSection:
            // Create full width item
            let horizontalItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(250)
                )
            )
            
            horizontalItem.contentInsets = NSDirectionalEdgeInsets(
                top: spacing/2,
                leading: spacing/2,
                bottom: spacing/2,
                trailing: spacing/2
            )
            
            // Create full width group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(250)
                ),
                subitems: [horizontalItem]
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: spacing/2,
                leading: spacing/2,
                bottom: spacing/2,
                trailing: spacing/2
            )
            return section
            
        default:
            // Original implementation for other section types
            let itemWidth = (containerWidth - spacing * 3) / 2
            
            let standardItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .estimated(itemWidth * 1.2)
                )
            )
            
            standardItem.contentInsets = NSDirectionalEdgeInsets(
                top: spacing/2,
                leading: spacing/2,
                bottom: spacing/2,
                trailing: spacing/2
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(itemWidth * 1.2)
                ),
                subitem: standardItem,
                count: 2
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            section.contentInsets = NSDirectionalEdgeInsets(
                top: spacing/2,
                leading: spacing/2,
                bottom: spacing/2,
                trailing: spacing/2
            )
            
            return section
        }
    }
    
//    private func createNormalProductSection(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//        let spacing: CGFloat = 2
//        let containerWidth = layoutEnvironment.container.effectiveContentSize.width
//        let itemWidth = (containerWidth - spacing * 3) / 2 // Account for spacing between items
//        
//        // Create standard item
//        let standardItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .absolute(itemWidth),
//                heightDimension: .absolute(itemWidth * 1.2) // Fixed aspect ratio
//            )
//        )
//        
//        // Add minimal spacing around items
//        standardItem.contentInsets = NSDirectionalEdgeInsets(
//            top: spacing/2,
//            leading: spacing/2,
//            bottom: spacing/2,
//            trailing: spacing/2
//        )
//        
//        // Create horizontal group with exactly 2 items
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .absolute(itemWidth * 1.2) // Same as item height
//            ),
//            subitem: standardItem,
//            count: 2
//        )
//        
//        // Create section
//        let section = NSCollectionLayoutSection(group: group)
//        
//        // Remove all spacing between groups
//        section.interGroupSpacing = 0
//        
//        // Minimal section insets
//        section.contentInsets = NSDirectionalEdgeInsets(
//            top: spacing/2,
//            leading: spacing/2,
//            bottom: spacing/2,
//            trailing: spacing/2
//        )
//        
//        return section
//    }
    
//    func createNormalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
//        // Create items with their respective width priorities
//        var items: [NSCollectionLayoutItem] = []
//        
//        for product in sectionDataSource[sectionIndex].products {
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(product.itemPriority),
//                    heightDimension: .estimated(200)
//                )
//            )
//            
//            // Reduce the content insets to minimal spacing
//            item.contentInsets = NSDirectionalEdgeInsets(
//                top: 10,    // Minimal top spacing
//                leading: 1, // Minimal left spacing
//                bottom: 10, // Minimal bottom spacing
//                trailing: 1 // Minimal right spacing
//            )
//            
//            items.append(item)
//        }
//        
//        // Create a horizontal group with absolute zero spacing
//        let group = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .estimated(100) // Reduce this to minimize gaps
//            ),
//            subitems: items
//        )
//        
//        // Create section with minimal spacing
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(
//            top: 0,
//            leading: 8,
//            bottom: 0,
//            trailing: 8
//        )
//        
//        // Critical: Set these to zero to remove vertical gaps
//        section.interGroupSpacing = 0
//        
//        return section
//    }
//    
//    func createNormalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
//        var products: [NSCollectionLayoutItem] = []
//        
//        // Create items with estimated height
//        for product in sectionDataSource[sectionIndex].products {
//            let productItem = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(product.itemPriority),
//                    heightDimension: .estimated(200) // Use estimated height instead of absolute
//                )
//            )
//            
//            productItem.contentInsets = NSDirectionalEdgeInsets(
//                top: 5,
//                leading: 3,
//                bottom: 5,
//                trailing: 3
//            )
//            
//            products.append(productItem)
//        }
//        
//        // Group
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .estimated(250)
//        )
//        
//        // Create group with the items
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: groupSize,
//            subitems: products
//        )
//        
//        // Section
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(
//            top: 0,
//            leading: 8,
//            bottom: 0,
//            trailing: 8
//        )
//        
//        return section
//    }
//    
//    func createNormalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
//        
//        var products: [NSCollectionLayoutItem] = []
//        
//        for (index, product) in sectionDataSource[sectionIndex].products.enumerated() {
//            if index == 0 {
//                let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(product.itemPriority), heightDimension: .absolute(187)))
//                productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
//                products.append(productItem)
//            }
//            else {
//                let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(product.itemPriority), heightDimension: .absolute(263)))
//                productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
//                products.append(productItem)
//            }
//            
//        }
//        
//        //Group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: products)
//        //Section
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
//        
//        return section
//    }
    
    func createLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        var products: [NSCollectionLayoutItem] = []

        // Create item
        
        for (index, product) in sectionDataSource[sectionIndex].products.enumerated() {
            if index == 0 {
                let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(product.itemPriority), heightDimension: .absolute(187)))
                productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
                products.append(productItem)
            }
            else {
                let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(product.itemPriority), heightDimension: .absolute(263)))
                productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
                products.append(productItem)
            }
            
        }
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .estimated(100) // This will adapt to actual content height
            )
        )
        
        // Add padding around each item
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
        
        // Create group that arranges items horizontally
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            ),
            subitem: item,
            count: 2  // Two items per row
        )
        
        // Create and configure section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
        
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
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(verticalProduct.itemPriority)))
            
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: products)
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(422))
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalGroup, productItem])
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 0, trailing: 8)
            return section
            
        }
        else {
            
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1))
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: products)
            //Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 0, trailing: 8)
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
        let horizontalProduct1 = ListingPageProductDTO(itemImage: "h1p1", itemType: .categoryItem, itemPriority: 0.5, categoryItemTitle: "Winter is Here", categoryItemDescription: "Discover the finest selection of jackets, hoodies, coats, and all your essential winter wear.", productStoreName: "", productPrice: "")
        let horizontalProduct2 = ListingPageProductDTO(itemImage: "h1p2", itemType: .categoryItem, itemPriority: 0.5, categoryItemTitle: "Holy Grails", categoryItemDescription: "Explore early releases and exclusive collaborations to shop your favorite sneakers.", productStoreName: "", productPrice: "")
        let horizontalProduct3 = ListingPageProductDTO(itemImage: "h1p3", itemType: .categoryItem, itemPriority: 0.7, categoryItemTitle: "Final Touches", categoryItemDescription: "Enhance your favorite outfits with designer jewelry and accessories.", productStoreName: "", productPrice: "")
        let horizontalProduct4 = ListingPageProductDTO(itemImage: "h1p4", itemType: .categoryItem, itemPriority: 0.8, categoryItemTitle: "Emerging Designers", categoryItemDescription: "Explore small businesses and discover unique, one-of-a-kind looks.", productStoreName: "", productPrice: "")
        let horizontalSection1 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .categoriesSection, products: [horizontalProduct1, horizontalProduct2, horizontalProduct3, horizontalProduct4])
        //Section 1
        let product1 = ListingPageProductDTO(itemImage: "s1p1", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "", categoryItemDescription: "", productStoreName: "Cloud Shoe 2024", productPrice: "R4 999.9")
        let product2 = ListingPageProductDTO(itemImage: "s1p2", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "", categoryItemDescription:  "", productStoreName: "Box Fit minecraft tea", productPrice: "R4 999.9")
        var section1 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product1, product2])
        //Section 2
        let product3 = ListingPageProductDTO(itemImage: "s2p1", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "", categoryItemDescription:  "", productStoreName: "No Breeze windreaker v2", productPrice: "R4 999.9")
        let product4 = ListingPageProductDTO(itemImage: "s2p2", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "", categoryItemDescription:  "", productStoreName: "AHD Roman Angel Cream", productPrice: "R4 999.9")
        var section2 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product3, product4])
        section1.products.append(contentsOf: section2.products)
        //Section 3
        let product5 = ListingPageProductDTO(itemImage: "s3p1", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "Winter is Here", categoryItemDescription:  "", productStoreName: "AHD Bonzai", productPrice: "R4 999.9")
        let product6 = ListingPageProductDTO(itemImage: "s3p2", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "Winter is Here", categoryItemDescription:  "", productStoreName: "Geneva Thrift", productPrice: "R4 999.9")
        let section3 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product5, product6])
        //Section 4
        let product7 = ListingPageProductDTO(itemImage: "s4p1", itemType: .verticalGroupItem, itemPriority: 0.35, categoryItemTitle: "Winter is Here", categoryItemDescription:  "", productStoreName: "Cloud Shoe 2024", productPrice: "R4 999.9")
        let product8 = ListingPageProductDTO(itemImage: "s4p2", itemType: .verticalGroupItem, itemPriority: 0.65, categoryItemTitle: "Winter is Here", categoryItemDescription:  "", productStoreName: "Cloud Shoe 2024", productPrice: "R4 999.9")
        let product9 = ListingPageProductDTO(itemImage: "s4p3", itemType: .verticalItem, itemPriority: 1, categoryItemTitle: "Winter is Here", categoryItemDescription:  "", productStoreName: "Cloud Shoe 2024", productPrice: "R4 999.9")
        let section4 = ListingPageProductSectionDTO(sectionName: "p2", sectionType: .verticalProductSection, products: [product7, product8, product9])
        //Section 5
        let product10 = ListingPageProductDTO(itemImage: "s5p1", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "Winter is Here", categoryItemDescription:  "", productStoreName: "Cloud Shoe 2024", productPrice: "R4 999.9")
        let product11 = ListingPageProductDTO(itemImage: "s5p2", itemType: .horizontalGroupItem, itemPriority: 0.5, categoryItemTitle: "Winter is Here", categoryItemDescription:  "", productStoreName: "Cloud Shoe 2024", productPrice: "R4 999.9")
        let section5 = ListingPageProductSectionDTO(sectionName: "p1", sectionType: .normalProductSection, products: [product10, product11])
        
        return [horizontalSection1, section1, section3, section4]
    }
    
    func createDataSourceAgain() -> [ListingPageProductSectionDTO] {
        // First vertical group (top left and bottom left)
        let leftGroup = ListingPageProductSectionDTO(
            sectionName: "left_group",
            sectionType: .verticalProductSection,
            products: [
                ListingPageProductDTO(
                    itemImage: "shoe_image",
                    itemType: .verticalGroupItem,
                    itemPriority: 0.5,
                    categoryItemTitle: "",
                    categoryItemDescription: "",
                    productStoreName: "Box Fit Minecraft Tee",
                    productPrice: "R4 999.99"
                ),
                ListingPageProductDTO(
                    itemImage: "jacket_yellow",
                    itemType: .verticalGroupItem,
                    itemPriority: 0.5,
                    categoryItemTitle: "",
                    categoryItemDescription: "",
                    productStoreName: "No Breeze Wind Br",
                    productPrice: "R16 999.99"
                )
            ]
        )
        
        // Second vertical group (top right and bottom right)
        let rightGroup = ListingPageProductSectionDTO(
            sectionName: "right_group",
            sectionType: .verticalProductSection,
            products: [
                ListingPageProductDTO(
                    itemImage: "tshirt_black",
                    itemType: .verticalGroupItem,
                    itemPriority: 0.5,
                    categoryItemTitle: "",
                    categoryItemDescription: "",
                    productStoreName: "Box Fit Minecraft Tee",
                    productPrice: "R349.99"
                ),
                ListingPageProductDTO(
                    itemImage: "tshirt_design",
                    itemType: .verticalGroupItem,
                    itemPriority: 0.5,
                    categoryItemTitle: "",
                    categoryItemDescription: "",
                    productStoreName: "A-H-D Oversized Tee",
                    productPrice: "R899.99"
                )
            ]
        )
        return [leftGroup, rightGroup]
    }
    
}

extension ListingPageViewController: UICollectionViewDataSource {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            self.lastContentOffset = scrollView.contentOffset.y
            let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
            if translation.y > 0 {
                self.scrollDirectionDelegate?.onViewScrolled(didScrollUp: false)
            }
            else {
                self.scrollDirectionDelegate?.onViewScrolled(didScrollUp: true)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            if self.lastContentOffset < scrollView.contentOffset.y {
                // did move up
                self.scrollDirectionDelegate?.onViewScrolled(didScrollUp: true)
            }
            else if self.lastContentOffset > scrollView.contentOffset.y {
                // did move down
                self.scrollDirectionDelegate?.onViewScrolled(didScrollUp: false)
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
        if sectionDataSource[indexPath.section].products[indexPath.row].itemType == .categoryItem {
            cell.productCategoryHeadingTitle.isHidden = false
            cell.productCategoryDescription.isHidden = false
            cell.shopCategoryButton.isHidden = false
            cell.productPriceInfoContainer.isHidden = true
            cell.productCategoryHeadingTitle.text = sectionDataSource[indexPath.section].products[indexPath.row].categoryItemTitle
            cell.productCategoryDescription.text = sectionDataSource[indexPath.section].products[indexPath.row].categoryItemDescription

        }
        else {
            cell.productCategoryHeadingTitle.isHidden = true
            cell.productCategoryDescription.isHidden = true
            cell.shopCategoryButton.isHidden = true
            cell.productPriceInfoContainer.isHidden = false
            cell.productPriceLabel.text = sectionDataSource[indexPath.section].products[indexPath.row].productPrice
            cell.productName.text = sectionDataSource[indexPath.section].products[indexPath.row].productStoreName
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ListingDetailPageViewController.self)) as? ListingDetailPageViewController
        vc?.modalPresentationStyle = .overCurrentContext
        self.navigationController?.pushViewController(vc!, animated: true)
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
