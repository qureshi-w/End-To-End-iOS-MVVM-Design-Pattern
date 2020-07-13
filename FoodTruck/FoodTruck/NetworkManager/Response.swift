//
//  Response.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit

//MARK: API Response
typealias Response = [FoodTruck]

// MARK: - APIError
enum APIError: Error {
    case invalidEndpoint
    case errorResponseDetected
    case noData
}

