//
//  AQMCityDataModel.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import Foundation
import UIKit

class AQMModel {
    /// Air quality index value
    var value: Float = 0.0
    /// Data on which date recieved
    var date: Date = Date()
    /// Intialize method
    init(value: Float, date: Date) {
        //2 decimal point representation
        if let twoPointValue: Float = Float(String(format: "%.2f", value)) {
            self.value = twoPointValue
        }
        self.date = date
    }
}

protocol AQMCityDataModelProtocol {
    var city: String { get set }
    var history: [AQMModel] { get set }
}

class AQMCityDataModel: AQMCityDataModelProtocol {
    var city: String
    var history: [AQMModel] = [AQMModel]()
    //Intialize method
    init(city: String) {
        self.city = city
    }
}

struct AQMQuideModel {
    let index: String
    let category: AQMIndexClassification
    let color: UIColor
}
