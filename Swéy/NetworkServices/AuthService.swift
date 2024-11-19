//
//  AuthService.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 16/10/2024.
//

import Foundation

struct AuthService {
    static let sharedInstance = AuthService()
    
    private init() {}
    
    func signupUser(signupDTO: UserSignupRequestDTO) async throws -> Void {
        let signupEndPoint = SweyEndPoints.signup(params: signupDTO)
        do {
            let networkResult: Result<BaseNetworkResponseDTO<String>, Error> = await NetworkManager.sharedInstance.makeNetworkRequest(endPoint: signupEndPoint)
            
            switch networkResult {
            case .success (let response):
                if response.statusCode == 200 {
                    print("Signup Succesfull")
                }
                break
            case .failure (let error):
                throw error
            }
        }
        catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func loginUser(loginDTO: LoginRequestDTO) async throws -> Void {
        let signupEndPoint = SweyEndPoints.login(params: loginDTO)
        do {
            let networkResult: Result<BaseNetworkResponseDTO<UserProfileDTO>, Error> = await NetworkManager.sharedInstance.makeNetworkRequest(endPoint: signupEndPoint)
            
            switch networkResult {
            case .success (let response):
                if response.statusCode == 200 {
                    UserDefaults.standard.set(response.data?.token, forKey: UserDefaultKeys.authToken.rawValue)
                    let encodedUserProfile = try JSONEncoder().encode(response.data?.user)
                    UserDefaults.standard.set(encodedUserProfile, forKey: UserDefaultKeys.userDetails.rawValue)
                }
                else {
                    throw SweyError.customError(response.statusMessage)
                }
                break
            case .failure (let error):
                print(error.localizedDescription)
                throw error
            }
        }
        catch {
            print(error)
            throw error
        }
    }
    
    func requestPasswordResetOTP(email: String) async throws -> RequestOTPResponseDTO? {
        let resetPasswordEndPoint = SweyEndPoints.requestPasswordResetOTP(params: ["email": email])
        do {
            let networkResult: Result<BaseNetworkResponseDTO<RequestOTPResponseDTO>, Error> = await NetworkManager.sharedInstance.makeNetworkRequest(endPoint: resetPasswordEndPoint)
            switch networkResult {
            case .success (let response):
                if response.statusCode == 200 {
                    return response.data
                }
                else {
                    throw SweyError.customError(response.statusMessage)
                }
            case .failure (let error):
                print(error)
                throw error
            }
        }
        catch {
            print(error)
            throw error
        }
    }

}
