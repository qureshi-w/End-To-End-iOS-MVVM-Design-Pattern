//
//  Utility.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit

class Constant: NSObject {

    //MARK: Constant
    static let BaseURL = "https://data.sfgov.org/resource/jjew-r69b.json"
    static let Cell = "Cell"
    static let MoveToMapViewSegue = "MoveToMapView"
    static let PinIdentifier = "Annotation"
    static let Title = "Food Trucks"
    static let Map = "Map"
    static let List = "List"
    static let Okay = "Okay"
    static let Cancel = "Cancel"

    func getEndPoint() -> String{
        let date = Date()
        let dayorder = date.dayNumberOfWeek()
        let nextHour = date.getNextHour()
        //Add 0 ahead of single digit to comply with API formate
        let nextHourStr = nextHour < 10 ? "0\(nextHour)" : "\(nextHour)"
        let endPoint = "?$where=dayorder=\(dayorder) and end24 between '\(nextHourStr):00' and '24:00'"
        return endPoint
    }
    
}


//MARK: Enum
enum MethodType : String{
    case GET
}

//MARK: Extension
extension Date {
    func dayNumberOfWeek() -> Int {
        // -1 as API takes Sunday = 0 and Method return Sunday as 1
        return Calendar.current.dateComponents([.weekday], from: self).weekday! - 1
    }
    
    func getNextHour() -> Int{
        // Add 1 to get include open restruant
        let modifiedDate = Calendar.current.date(byAdding: .hour, value: 1, to: self)
        return Calendar.current.component(.hour, from: modifiedDate!)
    }
}
