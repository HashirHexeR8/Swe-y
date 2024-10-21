//
//  BaseNetworkResponseDTO.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 16/10/2024.
//

import Foundation
struct BaseNetworkResponseDTO <T: Codable>: Codable {
    let statusMessage: String
    let statusCode: Int
    let data: T?
}
