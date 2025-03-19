//
//  ProfileService.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 24/11/2024.
//

import Foundation

struct ProfileService {
    static let sharedInstance = ProfileService()
    
    private init() {}
    
    func persistUserBillingDetails(params: PersistBillingDetailsRequestDTO) async throws -> Void {
        let persistBillingDetailsEnedpoint = SweyEndPoints.persistBillingDetails(params: params)
        do {
            let billingRequestResult: Result<BaseNetworkResponseDTO<String>, Error> = await NetworkManager.sharedInstance.makeNetworkRequest(endPoint: persistBillingDetailsEnedpoint)
            switch billingRequestResult {
            case .success (let response):
                if response.statusCode == 200 {
                    print("Billing Detail Success")
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
            throw error
        }
        
    }
}
