//
//  AQMResData+CoreDataClass.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 24/04/22.
//
//

import Foundation
import CoreData

@objc(AQMResData)
public class AQMResData: NSManagedObject, Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(city ?? "blank", forKey: .city)
            try container.encode(aqi, forKey: .aqi)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
        let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "AQMResData", in: managedObjectContext)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            city = try values.decode(String.self, forKey: .city)
            aqi = try values.decode(Float.self, forKey: .aqi)
        } catch {
            print ("error")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case aqi = "aqi"
    }
}
