//
//  AQMGraphPresenter.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 20/04/22.
//

import Foundation

class AQMGraphPresenter: GraphViewToPresenterProtocol {
    var view: GraphPresenterToViewProtocol?
    
    var interactor: GraphPresenterToInteractorProtocol?
    
    var router: GraphPresenterToRouterProtocol?
    
    func fetchingAQMData(city: String) {
        interactor?.fetchingAQMData(forCity: city)
    }
    
    func unsubscribe() {
        interactor?.unsubscribe()
    }
}

extension AQMGraphPresenter: GraphInteractorToPresenterProtocol {
    func fetchedAQMSuccess(data: AQMCityDataModel?) {
        view?.showAQMData(data: data)
    }
    
    func fetchFailed(error: String) {
        view?.showError(error: error)
    }
    
    func isLoading(isLoading: Bool) {
        view?.isLoading(isLoading: isLoading)
    }
}
