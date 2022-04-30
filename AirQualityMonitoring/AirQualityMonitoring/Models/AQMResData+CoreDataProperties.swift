//
//  AQMResData+CoreDataProperties.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 24/04/22.
//
//

import Foundation
import CoreData


extension AQMResData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AQMResData> {
        return NSFetchRequest<AQMResData>(entityName: "AQMResData")
    }

    @NSManaged public var aqi: Float
    @NSManaged public var city: String?

}

extension AQMResData : Identifiable {

}
