//
//  AQMListViewModelTests.swift
//  AirQualityMonitoringTests
//
//  Created by Nikunj Modi on 29/01/22.
//

import XCTest

@testable import AirQualityMonitoring

class AQMCoreDataAndUtiTests: XCTestCase {
    func testAQI() {
        let aqiClass = AQMIndexClassifier.classifyAirQualityIndex(aqi: 100)
        XCTAssertEqual(aqiClass, AQMIndexClassification.satisfactory)
        let color = AQMIndexColorClassifier.color(index: AQMIndexClassification.satisfactory)
        XCTAssertEqual(color, UIColor(hex: "#99C457"))
    }
    
    func testCoreData()  {
        let items = [AQMResponseData(city: "Pune", aqi: 100),
                      AQMResponseData(city: "Bombay", aqi: 200),
                      AQMResponseData(city: "Abad", aqi: 70)]
        let data = try! JSONEncoder().encode(items)
        CoreDataManager.sharedInstance.saveData(data: data)
        let coreData = CoreDataManager.sharedInstance.loadSavedData()
        XCTAssertEqual(coreData?.count, 3)
        CoreDataManager.sharedInstance.removeCoreData()
        let retriveData = CoreDataManager.sharedInstance.loadSavedData()
        XCTAssertEqual(retriveData?.count, 0)
    }
    
    func testTimeUti() {
        let str = Date().timeAgo()
        XCTAssertEqual(str, "0 seconds")
    }
}
