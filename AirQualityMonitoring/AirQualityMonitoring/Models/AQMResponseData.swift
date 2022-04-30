//
//  AQMResponseData.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import Foundation
import CoreData

struct AQMResponseData: Codable {
    /// City name
    var city: String
    /// Air quality index value
    var aqi: Float
    /// Intialize method
    init(city: String, aqi: Float) {
        self.city = city
        self.aqi = aqi
    }
}
