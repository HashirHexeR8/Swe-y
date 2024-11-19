//
//  SweyEndPoints.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 16/10/2024.
//

import Foundation

enum SweyEndPoints {
    case signup(params: UserSignupRequestDTO)
    case login(params: LoginRequestDTO)
    case requestPasswordResetOTP(params: [String: Any])
    
    var path: String {
        switch self {
            case .signup:
                return "api/auth/signup"
            case .login:
                return "api/auth/login"
            case .requestPasswordResetOTP:
                return "api/auth/request-otp"
        }
    }
    
    var methodType: HTTPMethod {
        switch self {
        case .signup, .login, .requestPasswordResetOTP:
            return .post
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .signup, .login, .requestPasswordResetOTP:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .signup(params: let params):
            return try? encodeParams(params)
        case .login(params: let params):
            return try? encodeParams(params)
        case .requestPasswordResetOTP(params: let params):
            return try? encodeParams(params)
        }
    }
    
    var baseURL: URL {
        .init(string: "http://16.170.254.219:5000/")!
    }
    
    var headers: [String: String] {
        var headers = ["Content-Type": "application/json"]
        switch self {
        case .signup, .login, .requestPasswordResetOTP:
            break
        }
        return headers
    }
    
    func encodeParams<T>(_ params: T) throws -> Data? {
        if let dictionary = params as? [String: Any] {
            return try JSONSerialization.data(withJSONObject: dictionary, options: [])
        } else if let encodableValue = params as? Encodable {
            let encoder = JSONEncoder()
            return try encoder.encode(encodableValue)
        }
        return nil
    }
}
