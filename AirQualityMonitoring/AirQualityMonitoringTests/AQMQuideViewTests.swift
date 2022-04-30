//
//  AQMListViewModelTests.swift
//  AirQualityMonitoringTests
//
//  Created by Nikunj Modi on 29/01/22.
//

import XCTest

@testable import AirQualityMonitoring

class AQMQuideViewTests: XCTestCase {
    var presenter: AQMQuidePresenter!
    var interactor = AQMQuideInteractor()
    var router = AQMQuideRouter()
    var view = AQMQuideRouter.createModule()
    
    override func setUp() {
      presenter = AQMQuidePresenter()
      presenter.view = view
      presenter.interactor = interactor
      interactor.presenter = presenter
    }

    func testfetchallAQMData() {
        presenter.fetchingAQMQuideData()
    }
    
    func testCreateModule() {
        XCTAssertNotNil(view, "Got Proper UIViewController")
    }
}
