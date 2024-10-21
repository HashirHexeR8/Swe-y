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
                    //UserDefaults.standard.set(response.data?.token, forKey: UserDefaultKeys.authToken.rawValue)
                    //UserDefaults.standard.set(response.data, forKey: UserDefaultKeys.userDetails.rawValue)
                }
                break
            case .failure (let error):
                print(error.localizedDescription)
                throw error
            }
        }
        catch {
            print(error.localizedDescription)
            throw error
        }
    }

}
