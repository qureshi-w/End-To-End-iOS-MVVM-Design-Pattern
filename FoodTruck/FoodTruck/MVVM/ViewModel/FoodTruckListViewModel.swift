//
//  FoodTruckListViewModel.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit


protocol FoodTruckViewModelDelegate: class {
    func updateList(_ foodTruckViewModel : [FoodTruckViewModel])
    func didFailToFetch(with error:Error)
}

class FoodTruckListViewModel {
    
    weak var delegate: FoodTruckViewModelDelegate?
    func fetchFoodTruckList() {
        NetworkManager.shared.request(baseURL: Constant.BaseURL, endPoint: Constant().getEndPoint(),.GET,
                                      
                                      onSuccess: {[weak self] response in
                                        let sortedArray = response.sorted{ $0.applicant < $1.applicant }
                                        let foodTrucks = sortedArray.compactMap { FoodTruckViewModel(model: $0) }
                                        self?.delegate?.updateList(foodTrucks)
            },
                                      onError: {[weak self] error in
                                        self?.delegate?.didFailToFetch(with: error)
        })
    }
}

