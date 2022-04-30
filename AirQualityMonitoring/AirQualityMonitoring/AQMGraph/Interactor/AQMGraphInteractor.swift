//
//  AQMGraphInteractor.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 20/04/22.
//

import Foundation
import RxSwift

class AQMGraphInteractor : GraphPresenterToInteractorProtocol {
    private var city: String = ""
    var prevItem: AQMCityDataModel? = nil
    var item = PublishSubject<AQMCityDataModel>()
    var presenter: GraphInteractorToPresenterProtocol?
    //private let service: NetworkManager
    private var provider: AQMDataProvider?
    let disposeBag = DisposeBag()
    
    func fetchingAQMData(forCity: String) {
        self.city = forCity
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

extension AQMGraphInteractor: AQMDataProviderDelegate {

    // Recieved response from DataProvider
    func didReceive(response: Result<[AQMResponseData], Error>) {
        switch response {
        case .success(let response):
            parseAndNotify(resArray: response)
        case .failure(let error):
            handleError(error: error)
        }
    }

    /// Helper to didReceive() method for parsing data
    func parseAndNotify(resArray: [AQMResponseData]) {
        let cityData = resArray.filter { $0.city == city }
        if let data = cityData.first {
            if let prev = prevItem {
                prev.history.append(AQMModel(value: data.aqi, date: Date()))
            } else {
                prevItem = AQMCityDataModel(city: self.city)
                prevItem?.history.append(AQMModel(value: data.aqi, date: Date()))
            }
        } else {
            if let prev = prevItem, let last = prev.history.last {
                prev.history.append(last)
            }
        }
        if let prevRecord = prevItem {
            //item.onNext(prevRecord)
            presenter?.fetchedAQMSuccess(data: prevRecord)
        }
    }

    // Helper to didReceive() method for error handling
    func handleError(error: Error?) {
        if let error = error {
            item.onError(error)
        }
    }
}
