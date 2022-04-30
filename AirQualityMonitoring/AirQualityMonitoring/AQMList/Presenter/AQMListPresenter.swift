//
//  AQMListPresenter.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 18/04/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AQMListPresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func fetchingAQMData() {
        interactor?.fetchingAQMData()
    }
    
    func unsubscribe() {
        interactor?.unsubscribe()
    }
    
    func showAQMGraphViewController(navigationController: UINavigationController, AQMCityData: AQMCityDataModel) {
        router?.showGraphController(navigationController: navigationController, AQMCityData: AQMCityData)
    }
    
    func showQuideController(sender: UIBarButtonItem, delegate: AQMListViewController) {
        router?.showQuideController(sender: sender, delegate: delegate)
    }
}

extension AQMListPresenter: InteractorToPresenterProtocol {
    func fetchedAQMSuccess(data: [AQMCityDataModel]?) {
        view?.showAQMData(data: data)
    }
    
    func fetchFailed(error: String) {
        view?.showError(error: error)
    }
    
    func isLoading(isLoading: Bool) {
        view?.isLoading(isLoading: isLoading)
    }
}
