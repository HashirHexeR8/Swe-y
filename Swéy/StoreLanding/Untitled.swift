////
////  Untitled.swift
////  Swey
////
////  Created by Muhammad Hashir Rafique on 27/01/2025.
////
import UIKit

class PinterestLayout: UICollectionViewLayout {
    // MARK: - Properties
    private var cache: [Int: [UICollectionViewLayoutAttributes]] = [:]
    private var contentHeight: CGFloat = 0
    private let spacing: CGFloat = 4
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - Layout
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        cache.removeAll()
        contentHeight = 0
        
        for section in 0..<collectionView.numberOfSections {
            guard let sectionType = getSectionType(for: section) else { continue }
            
            switch sectionType {
            case .normalProductSection:
                layoutNormalProductSection(section)
            case .verticalProductSection:
                layoutVerticalProductSection(section)
            case .categoriesSection:
                layoutCategoriesSection(section)
            case .horizontalProductSection:
                return
            }
        }
    }
    
    private func layoutNormalProductSection(_ section: Int) {
        guard let collectionView = collectionView else { return }
        
        var sectionAttributes: [UICollectionViewLayoutAttributes] = []
        var columnHeights: [CGFloat] = [contentHeight, contentHeight]
        let columnWidth = (contentWidth - spacing * 3) / 2
        
        for item in 0..<collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: item, section: section)
            
            let width = columnWidth
            let height = getItemHeight(for: indexPath, width: width)
            
            let column = columnHeights[0] <= columnHeights[1] ? 0 : 1
            let xOffset = spacing + (columnWidth + spacing) * CGFloat(column)
            let yOffset = columnHeights[column]
            
            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            
            sectionAttributes.append(attributes)
            columnHeights[column] = yOffset + height + spacing
            contentHeight = max(contentHeight, frame.maxY + spacing)
        }
        
        cache[section] = sectionAttributes
    }
    
    private func layoutCategoriesSection(_ section: Int) {
        guard let collectionView = collectionView else { return }
        
        var sectionAttributes: [UICollectionViewLayoutAttributes] = []
        let yOffset = contentHeight
        
        let itemWidth = contentWidth - spacing * 2
        let itemHeight: CGFloat = 200 // Adjust as needed
        
        for item in 0..<collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: item, section: section)
            let frame = CGRect(x: spacing, y: yOffset + CGFloat(item) * (itemHeight + spacing),
                             width: itemWidth, height: itemHeight)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            sectionAttributes.append(attributes)
        }
        
        if let lastAttribute = sectionAttributes.last {
            contentHeight = lastAttribute.frame.maxY + spacing
        }
        
        cache[section] = sectionAttributes
    }
    
    private func layoutVerticalProductSection(_ section: Int) {
        guard let collectionView = collectionView else { return }
        
        var sectionAttributes: [UICollectionViewLayoutAttributes] = []
        let yOffset = contentHeight
        
        // Handle vertical items differently
        let verticalWidth = contentWidth * 0.4
        let verticalHeight = contentHeight + 422 // Match your existing height
        
        for item in 0..<collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: item, section: section)
            let product = getProduct(for: indexPath)
            
            let frame: CGRect
            if product?.itemType == .verticalItem {
                frame = CGRect(x: contentWidth - verticalWidth - spacing,
                             y: yOffset,
                             width: verticalWidth,
                             height: verticalHeight)
            } else {
                let groupWidth = contentWidth * 0.6 - spacing * 2
                frame = CGRect(x: spacing,
                             y: yOffset + (item == 0 ? 0 : verticalHeight/2),
                             width: groupWidth,
                             height: verticalHeight/2)
            }
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            sectionAttributes.append(attributes)
        }
        
        contentHeight = yOffset + verticalHeight + spacing
        cache[section] = sectionAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for (_, attributes) in cache {
            visibleLayoutAttributes.append(contentsOf: attributes.filter { $0.frame.intersects(rect) })
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.section]?[indexPath.item]
    }
    
    // MARK: - Helper Methods
    private func getSectionType(for section: Int) -> ListingPageSectionType? {
        guard let collectionView = collectionView,
              let viewController = collectionView.delegate as? ListingPageViewController else { return nil }
        return viewController.sectionDataSource[section].sectionType
    }
    
    private func getProduct(for indexPath: IndexPath) -> ListingPageProductDTO? {
        guard let collectionView = collectionView,
              let viewController = collectionView.delegate as? ListingPageViewController else { return nil }
        return viewController.sectionDataSource[indexPath.section].products[indexPath.item]
    }
    
    private func getItemHeight(for indexPath: IndexPath, width: CGFloat) -> CGFloat {
        guard let product = getProduct(for: indexPath) else { return width }
        
        switch product.itemType {
        case .horizontalGroupItem:
            return width * 1.2
        case .verticalGroupItem:
            return width * 1.5
        case .verticalItem:
            return width * 0.8
        case .categoryItem:
            return width * 1.0
        case .horizontalItem:
            return width
        }
    }
}
