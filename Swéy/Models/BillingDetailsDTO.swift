//
//  BillingDetailsDTO.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 24/11/2024.
//

import Foundation

struct PersistBillingDetailsRequestDTO: Codable {
    var propertyType: Int = 0
    var country: String = ""
    var city: String = ""
    var address: String = ""
    var zip: String = ""
    
    init() {}
}
