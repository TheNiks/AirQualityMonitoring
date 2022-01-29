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

    private var viewModel: AQMListViewModel?
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
        viewModel = AQMListViewModel(dataProvider: AQMDataProvider())
        bindTableData()
    }

    /// Bind ListViewModel's items to get updated CityDataModel data. Also tapping on cell is handled here
    func bindTableData() {

        viewModel?.items.bind(to: tableView.rx.items(cellIdentifier: "AQMCityDataTableViewCell", cellType: AQMCityDataTableViewCell.self)) {row, model, cell in
            cell.cityData = model
        }.disposed(by: bag)

        tableView.rx.modelSelected(AQMCityDataModel.self).bind { item in
            let cityDetail: AQMGraphViewController = self.storyboard?.instantiateViewController(identifier: "AQMGraphVC") as! AQMGraphViewController
            cityDetail.cityModel = item
            self.navigationController?.pushViewController(cityDetail, animated: true)
        }.disposed(by: bag)


        /// Set delegate
        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }

    /// Life cycle method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.subscribe()
    }

    //Life cycle method
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.unsubscribe()
    }

    //IBAction for right navigation bar item for info screen
    @IBAction func infoTapped(_ sender: UIBarButtonItem) {
        let infoDetail: AQMQuideViewController = self.storyboard?.instantiateViewController(identifier: "AQMQuideVC") as! AQMQuideViewController
        infoDetail.preferredContentSize = CGSize(width: Int(self.view.frame.width) - 30, height: (AQMIndexClassification.allCases.count) * 60 + 5)
        infoDetail.modalPresentationStyle = .popover
        let popoverVC = infoDetail.popoverPresentationController
        popoverVC?.barButtonItem = sender
        popoverVC?.delegate = self
        popoverVC?.permittedArrowDirections = .any
        self.present(infoDetail, animated: true, completion: nil)
    }
    
    /// Life cycle method
    deinit {
        viewModel?.unsubscribe()
    }
}

// MARK:- Delegate methods for UI changes in table view
extension AQMListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

// MARK:- UIPopoverPresentationControllerDelegate
extension AQMListViewController:UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
