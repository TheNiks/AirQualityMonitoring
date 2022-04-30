//
//  CoreDataManager.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 24/04/22.
//

import Foundation
import UIKit
import CoreData

open class CoreDataManager: NSObject {
    
    public static let sharedInstance = CoreDataManager()
    
    private override init() {}
    var data = [NSManagedObject]()
    // Helper func for getting the current context.
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }

    func saveData(data: Data) {
        if let context = getContext() {
            do {
                self.removeCoreData()
                let decoder = JSONDecoder()
                // Assign the NSManagedIbject Context to the decoder
                decoder.userInfo[CodingUserInfoKey.context!] = context
                let commitData = try decoder.decode([AQMResData].self, from: data) // Commit rather than CommmitData
                // print("Received \(commitData.count) new commits.")
                self.saveContext()
            } catch let error {
                // print("Err", err)
            }
        }
    }
    
    func loadSavedData() -> [AQMResponseData]? {
        if let context = getContext() {
            let request: NSFetchRequest<AQMResData> = AQMResData.fetchRequest()
            //let sort = NSSortDescriptor(key: "AQMResData", ascending: false)
            //request.sortDescriptors = [sort]
            var modelData = [AQMResponseData]()
            do {
                // fetch is performed on the NSManagedObjectContext
                data = try context.fetch(request)
                for record in data {
                    let model = AQMResponseData(city: record.value(forKey: "city") as! String, aqi: record.value(forKey: "aqi") as! Float)
                    modelData.append(model)
                }
                return modelData
            } catch {
                // print("Fetch failed")
            }
        }
        return nil
    }
    
    func saveContext() {
        if let context = getContext() {
            if context.hasChanges {
                do {
                    print ("Saved")
                    try context.save()
                } catch {
                    // print("An error occurred while saving: \(error)")
                }
            }
        }
    }
    
    func removeCoreData() {
        if let context = getContext() {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "AQMResData") // Find this name in your .xcdatamodeld file
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                // TODO: handle the error
                // print(error.localizedDescription)
            }
        }
    }
}
