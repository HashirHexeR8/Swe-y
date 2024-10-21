//
//  SignupUserDTO.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 16/10/2024.
//

import Foundation

struct UserSignupRequestDTO: Codable {
    var email: String = ""
    var password: String = ""
    var dateOfBirth: String = ""
    var phoneNumber: String = ""
    var username: String = ""
    
    init() {
    }
}

struct UserProfileDTO: Codable {
    let token: String
    let user: UserDTO
}

struct UserDTO: Codable {
    let username: String
    let email: String
    let dateOfBirth: String
    let phoneNumber: String
}
