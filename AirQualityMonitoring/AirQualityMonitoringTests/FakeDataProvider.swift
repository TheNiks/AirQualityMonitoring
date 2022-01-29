//
//  FakeDataProvider.swift
//  AirQualityMonitoringTests
//
//  Created by Nikunj Modi on 29/01/22.
//

import XCTest

@testable import AirQualityMonitoring

// MARK:- Tests fake data
let fakeResponse: [AQMResponseData] = [AQMResponseData(city: "Hyderabad", aqi: 200.0)]
let fakeDataProvider: AQMDataProvider = AQMFakeDataProvider(fakeResponse: .success(fakeResponse))

let fakeDataProviderError: AQMDataProvider
    = AQMFakeDataProvider(fakeResponse: .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Error Message"])))
