//
//  FoodTruckDetailCell.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit

class FoodTruckDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblOpenTime: UILabel!
    
    var foodTruck : FoodTruckViewModel! {
        didSet {
            self.lblName.text = foodTruck.applicantName
            self.lblAdress.text = foodTruck.address
            self.lblDescription.text = foodTruck.description
            self.lblOpenTime.text =  foodTruck.openTime
        }
    }
}
