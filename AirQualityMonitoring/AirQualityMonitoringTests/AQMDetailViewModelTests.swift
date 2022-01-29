//
//  AQMDetailViewModelTests.swift
//  AirQualityMonitoringTests
//
//  Created by Nikunj Modi on 29/01/22.
//

import XCTest
import RxSwift
import Nimble
import RxNimble

@testable import AirQualityMonitoring

class AQMDetailViewModelTests: XCTestCase {
    let detailViewModel: AQMDetailViewModel = AQMDetailViewModel(dataProvider: fakeDataProvider)

    let detailViewModelError: AQMDetailViewModel = AQMDetailViewModel(dataProvider: fakeDataProviderError)

    func testRespnoseDataInformation() {
        detailViewModel.subscribe(forCity: "Hyderabad")

        expect(self.detailViewModel.prevItem?.city) == fakeResponse.first?.city
        expect(self.detailViewModel.prevItem?.history.last?.value) == fakeResponse.first?.aqi

        detailViewModel.unsubscribe()
    }

    func testDataInformationWhenPrevItemsAvailable() {
        let item = AQMCityDataModel(city: "Pune")
        item.history = [AQMModel(value: 100, date: Date())]
        detailViewModel.prevItem = item
        detailViewModel.subscribe(forCity: "Pune")
        expect(self.detailViewModel.prevItem?.city) == "Pune"
        expect(self.detailViewModel.prevItem?.history.last?.value) == 100
        detailViewModel.unsubscribe()
    }

    func testErrorResponse() {
        detailViewModelError.subscribe(forCity: "Hyderabad")
        let p = self.detailViewModelError.prevItem
        expect(p).to(beNil())
    }
}
