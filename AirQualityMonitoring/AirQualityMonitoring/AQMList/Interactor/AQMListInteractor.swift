//
//  AQMListInteractor.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 18/04/22.
//

import Foundation
import RxSwift
 
class AQMListInteractor : PresenterToInteractorProtocol {
    var prevItems: [AQMCityDataModel] = [AQMCityDataModel]()
    var items = PublishSubject<[AQMCityDataModel]>()
    var presenter: InteractorToPresenterProtocol?
    private var provider: AQMDataProvider?
    
    func fetchingAQMData() {
        provider?.subscribe()
    }
    
    init(service: AQMDataProvider = AQMDataProvider()) {
        provider = service
        provider?.delegate = self
    }
    
    func unsubscribe() {
        provider?.unsubscribe()
    }
}

extension AQMListInteractor: AQMDataProviderDelegate {

    // Recieved response from DataProvider
    func didReceive(response: Result<[AQMResponseData], Error>) {
        switch response {
        case .success(let response):
            parseAndNotify(resArray: response)
        case .failure(let error):
            handleError(error: error)
        }
    }

    // Helper to didReceive() method for parsing data
    func parseAndNotify(resArray: [AQMResponseData]) {
        if prevItems.count == 0 {
            for record in resArray {
                let model = AQMCityDataModel(city: record.city)
                model.history.append(AQMModel(value: record.aqi, date: Date()))
                prevItems.append(model)
            }
        } else {
            for record in resArray {
                let matchedResults = prevItems.filter { $0.city == record.city }
                if let matchedRes = matchedResults.first {
                    matchedRes.history.append(AQMModel(value: record.aqi, date: Date()))
                } else {
                    let model = AQMCityDataModel(city: record.city)
                    model.history.append(AQMModel(value: record.aqi, date: Date()))
                    prevItems.append(model)
                }
            }
        }
        presenter?.fetchedAQMSuccess(data: prevItems)
    }

    // Helper to didReceive() method for error handling
    func handleError(error: Error?) {
        if let error = error {
            //items.onError(error)
            presenter?.fetchFailed(error: error.localizedDescription)
        }
    }
}
