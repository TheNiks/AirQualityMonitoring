//
//  AQMQuideViewController.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import UIKit
import RxSwift
import RxCocoa

class AQMQuideViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: AQMQuideViewModel?

    /// Thread safe bag that disposes added disposables on `deinit`.
    private var bag = DisposeBag()

    /// Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AQMQuideViewModel()
        bindTableData()
        viewModel?.setupAQMGuide()
    }

    func bindTableData() {
        /// Bind items to table
        viewModel?.items.bind(to: tableView.rx.items(cellIdentifier: "AQMQuideTableViewCell", cellType: AQMQuideTableViewCell.self)) {row, model, cell in
            cell.guideData = model
        }.disposed(by: bag)

        /// Set delegate
        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }
}

// MARK:- Delegate methods for UI changes in table view
extension AQMQuideViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
