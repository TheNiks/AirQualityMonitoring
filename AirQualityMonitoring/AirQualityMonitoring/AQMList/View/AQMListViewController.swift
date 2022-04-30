//
//  AQMListViewController.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import UIKit
import RxCocoa
import RxSwift

class AQMListViewController: UIViewController {
    var presentor:ViewToPresenterProtocol?
    var data: [AQMCityDataModel] = []
    /// Thread safe bag that disposes added disposables on `deinit`.
    private var bag = DisposeBag()
    /// UITableView instance
    @IBOutlet var tableView: UITableView!
    @IBOutlet var infoBarButtonItem: UIBarButtonItem!
    
    /// Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Use in UITest for button action
        infoBarButtonItem.accessibilityIdentifier = "infoNavBarRightItem"
        infoBarButtonItem.isAccessibilityElement = true
        //Use in UITest for table view
        tableView.accessibilityIdentifier = "table--cityTableView"
        bindTableData()
    }

    /// Bind ListViewModel's items to get updated CityDataModel data. Also tapping on cell is handled here
    func bindTableData() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    /// Life cycle method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPresenter()
    }

    /// fetch AQM API information
    private func fetchPresenter() {
       presentor?.fetchingAQMData()
    }
    
    /// Life cycle method
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentor?.unsubscribe()
    }

    //IBAction for right navigation bar item for info screen
    @IBAction func infoTapped(_ sender: UIBarButtonItem) {
        presentor?.showQuideController(sender: sender, delegate: self)
    }
    
    /// Life cycle method
    deinit {
        presentor?.unsubscribe()
    }
}

// MARK:- Delegate methods for UI changes in table view
extension AQMListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AQMCityDataTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "AQMCityDataTableViewCell", for: indexPath) as! AQMCityDataTableViewCell
        cell.cityData = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentor?.showAQMGraphViewController(navigationController: navigationController ?? UINavigationController(), AQMCityData: data[indexPath.row])
    }
}

// MARK:- UIPopoverPresentationControllerDelegate
extension AQMListViewController:UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension AQMListViewController: PresenterToViewProtocol {
    func showAQMData(data: [AQMCityDataModel]?) {
        self.data = data ?? []
        guard let tableView = self.tableView else {
            return
        }
        tableView.reloadData()
    }
    
    func showError(error: String) {
        // I do it later
    }
    
    func isLoading(isLoading: Bool) {
        // I do it later
    }
}
