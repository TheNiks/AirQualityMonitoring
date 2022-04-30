//
//  AQMListViewModelTests.swift
//  AirQualityMonitoringTests
//
//  Created by Nikunj Modi on 29/01/22.
//

import XCTest

@testable import AirQualityMonitoring

class AQMListViewControllerTests: XCTestCase {
    
    var viewControllerUnderTest: AQMListViewController!
    
    override func setUp() {
        super.setUp()
        
        self.viewControllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AQMListVC") as? AQMListViewController
        
        let item = AQMCityDataModel(city: "Pune")
        item.history = [AQMModel(value: 100, date: Date())]
        self.viewControllerUnderTest.data = [item]
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AQMCityDataTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "AQMCityDataTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {
        let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AQMCityDataTableViewCell
        XCTAssertEqual(cell0?.lblCity.text, "Pune")
    }
}
