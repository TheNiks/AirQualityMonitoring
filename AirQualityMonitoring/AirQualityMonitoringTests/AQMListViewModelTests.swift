//
//  AQMListViewModelTests.swift
//  AirQualityMonitoringTests
//
//  Created by Nikunj Modi on 29/01/22.
//

import XCTest
import RxSwift
import RxNimble
import Nimble

@testable import AirQualityMonitoring

class AQMListViewModelTests: XCTestCase {
    let listViewModel: AQMListViewModel = AQMListViewModel(dataProvider: fakeDataProvider)
    let listViewModelError: AQMListViewModel = AQMListViewModel(dataProvider: fakeDataProviderError)

    func testRespnoseDataInformation() {
        listViewModel.subscribe()
        expect(self.listViewModel.prevItems.first?.city) == fakeResponse.first?.city
        expect(self.listViewModel.prevItems.first?.history.last?.value) == fakeResponse.first?.aqi
        listViewModel.unsubscribe()
    }

    func testDataInformationWhenPrevItemsAvailable() {
        let item = AQMCityDataModel(city: "Pune")
        item.history = [AQMModel(value: 100, date: Date())]
        listViewModel.prevItems = [item]
        listViewModel.subscribe()
        expect(self.listViewModel.prevItems.first?.city) == "Pune"
        expect(self.listViewModel.prevItems.first?.history.last?.value) == 100
        listViewModel.unsubscribe()
    }

    func testErrorResponse() {
        listViewModelError.subscribe()
        let p = self.listViewModelError.prevItems
        expect(p.count) == 0
    }
}
