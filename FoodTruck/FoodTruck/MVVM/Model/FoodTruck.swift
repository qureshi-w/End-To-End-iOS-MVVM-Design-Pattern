//
//  FoodTruck.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit


// MARK: - FoodTruck
struct FoodTruck: Codable {
    
    let dayorder: String
    let dayofweekstr: String
    let starttime, endtime: String
    let permit, location: String
    let locationdesc, optionaltext: String?
    let locationid: String
    let start24, end24: String
    let cnn, addr_date_create: String
    let addr_date_modified, block, lot: String?
    let coldtruck: String
    let applicant, x, y, latitude: String
    let longitude: String
    let location_2: Location2
}

// MARK: - Location2
struct Location2: Codable {
    let type: String
    let coordinates: [Double]
}
