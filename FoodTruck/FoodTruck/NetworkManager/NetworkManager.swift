//
//  Network.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit


class NetworkManager {
    
    private init() {}
    static let shared = NetworkManager()
    
    func request(
        baseURL: String,
        endPoint: String,
        _ type: MethodType,
        onSuccess: @escaping ((_: Response) -> Void),
        onError: @escaping ((_: Error) -> Void))
    {
        guard let urlString = "\(baseURL)\(endPoint)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else  {
               onError(APIError.invalidEndpoint)
               return
        }
        
        guard let endpointUrl = URL(string: urlString) else {
            onError(APIError.invalidEndpoint)
            return
        }
        
        var endpointRequest = URLRequest(url: endpointUrl)
        endpointRequest.httpMethod = type.rawValue
        endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Ephemeral as we need fresh data every time.
        URLSession(configuration: .ephemeral).dataTask(
            with: endpointRequest,
            completionHandler: { (data, urlResponse, error) in
                self.processResponse(data, urlResponse, error, onSuccess: onSuccess, onError: onError)
                
        }).resume()
    }
    
    private func processResponse(
        
        _ dataOrNil: Data?,
        _ urlResponseOrNil: URLResponse?,
        _ errorOrNil: Error?,
        onSuccess: ((_: Response) -> Void),
        onError: ((_: Error) -> Void)) {
        
        if let data = dataOrNil {
            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                if decodedResponse.count > 0 {
                    onSuccess(decodedResponse)
                }else{
                    onError(APIError.noData)
                }
            } catch {
                onError(APIError.errorResponseDetected)
            }
        } else {
            onError(errorOrNil ?? APIError.noData)
        }
    }
    
}

