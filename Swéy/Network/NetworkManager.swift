//
//  NetworkManager.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 16/10/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkResult<Data, Error> {
    case success(Data)
    case failure(Error)
}

struct NetworkManager {
    static let sharedInstance = NetworkManager()
    
    private init() {}
    
    func makeNetworkRequest<T: Decodable>(endPoint: SweyEndPoints) async -> Result<BaseNetworkResponseDTO<T>, Error> {
        let urlRequest = createUrlRequest(endPoint: endPoint)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                print("Invalid response from server: \(response)\nstatus code: \((response as? HTTPURLResponse)?.statusCode ?? -1)\nfor path \(endPoint.path)")
                return .failure(NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
            }
            
            let jsonResponse = try JSONDecoder().decode(BaseNetworkResponseDTO<T>.self, from: data)
            return .success(jsonResponse as! BaseNetworkResponseDTO<T>)
        }
        catch {
            print(error)
            return .failure(error)
        }
    }
    
    private func createUrlRequest(endPoint: SweyEndPoints) -> URLRequest {
        let url = endPoint.baseURL.appendingPathComponent(endPoint.path)
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.methodType.rawValue
                        
        // Set headers if provided
        for (key, value) in endPoint.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Set parameters in request URL if provided
        if let parameters = endPoint.queryParams {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            request.url = urlComponents?.url
        }
        
        if let body = endPoint.httpBody {
            request.httpBody = body
        }
        
        return request
    }
}
