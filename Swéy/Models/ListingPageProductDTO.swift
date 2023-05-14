//
//  ListingPageProductDTO.swift
//  Swey
//
//  Created by Muhammad Hashir on 5/14/23.
//

import Foundation

struct ListingPageProductSectionDTO {
    var sectionName: String
    var sectionType: ListingPageSectionType
    var products: [ListingPageProductDTO]
}

struct ListingPageProductDTO {
    var itemImage: String
    var itemType: ProductItemType
    var itemPriority: Double
}
