//
//  AQMQuidePresenter.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 21/04/22.
//

import Foundation
class AQMQuidePresenter: QuideViewToPresenterProtocol {
    var view: QuidePresenterToViewProtocol?
    var interactor: QuidePresenterToInteractorProtocol?
    var router: QuidePresenterToRouterProtocol?
    
    func fetchingAQMQuideData() {
        interactor?.fetchingAQMQuideData()
    }
}

extension AQMQuidePresenter: QuideInteractorToPresenterProtocol {
    func fetchedAQMSuccess(data: [AQMQuideModel]) {
        view?.showAQMGuideData(data: data)
    }
    
    func fetchFailed(error: String) {
        view?.showError(error: error)
    }
    
    func isLoading(isLoading: Bool) {
        view?.isLoading(isLoading: isLoading)
    }
}
