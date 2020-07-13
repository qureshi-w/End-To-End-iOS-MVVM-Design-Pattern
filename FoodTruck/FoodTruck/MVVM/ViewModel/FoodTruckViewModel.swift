//
//  FoodTruckViewModel.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit

struct FoodTruckViewModel {
    
    let applicantName: String
    let address: String
    let description: String
    let openTime: String
    let latitude: Double
    let longitude: Double

    
    // Dependency Injection (DI)
    init(model:FoodTruck) {
        
        self.applicantName = model.applicant
        self.address = model.location
        self.description = model.optionaltext ?? ""
        self.openTime =  "\(model.starttime) - \(model.endtime )"
        self.longitude = model.location_2.coordinates[0]
        self.latitude = model.location_2.coordinates[1]
    }
}
