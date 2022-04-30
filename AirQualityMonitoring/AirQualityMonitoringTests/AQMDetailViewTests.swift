//
//  AQMDetailViewModelTests.swift
//  AirQualityMonitoringTests
//
//  Created by Nikunj Modi on 29/01/22.
//

import XCTest

@testable import AirQualityMonitoring

class AQMDetailViewTests: XCTestCase {
    
    var presenter: AQMGraphPresenter!
    var interactor = AQMGraphInteractorMock()
    var view = AQMGraphRouter.createModule()

    override func setUp() {
      presenter = AQMGraphPresenter()
      presenter.view = view
      presenter.interactor = interactor
      interactor.presenter = presenter
    }

    func testfetchallAQMData() {
        presenter.fetchingAQMData(city: "Hyderabad")
    }
    
    func testUnsubscribe() {
        presenter.unsubscribe()
    }
    
    func testCreateModule() {
        XCTAssertNotNil(view, "Got Proper UIViewController")
    }
}

class  AQMGraphInteractorMock: GraphPresenterToInteractorProtocol {
    var presenter: GraphInteractorToPresenterProtocol?
    
    func fetchingAQMData(forCity: String) {
        let item = AQMCityDataModel(city: forCity)
        item.history = [AQMModel(value: 300, date: Date())]
        presenter?.fetchedAQMSuccess(data: item)
    }
    
    func unsubscribe() {
    }
}
