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
    var presentor: QuideViewToPresenterProtocol?
    var data: [AQMQuideModel] = []
    
    /// Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        presentor?.fetchingAQMQuideData()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK:- Delegate methods for UI changes in table view
extension AQMQuideViewController: UITableViewDelegate, UITableViewDataSource {
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
        let cell:AQMQuideTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "AQMQuideTableViewCell", for: indexPath) as! AQMQuideTableViewCell
        cell.guideData = data[indexPath.row]
        return cell
    }
}

extension AQMQuideViewController: QuidePresenterToViewProtocol {
    func showAQMGuideData(data: [AQMQuideModel]) {
        self.data = data
        guard let tableView = self.tableView else {
            return
        }
        tableView.reloadData()
    }

    func showError(error: String) {
        // Do it later
    }
    
    func isLoading(isLoading: Bool) {
        // Do it later
    }
}
