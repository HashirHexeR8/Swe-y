//
//  CategoryFilterItemDTO.swift
//  Swey
//
//  Created by Builds on 16/08/2024.
//

import Foundation

class CategoryFilterItemDTO {
    var categoryName: String
    var isSelected: Bool
    
    init(categoryName: String, isSelected: Bool) {
        self.categoryName = categoryName
        self.isSelected = isSelected
    }
}
