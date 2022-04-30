//
//  AQMGraphProtocol.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 20/04/22.
//

import Foundation
import UIKit

protocol GraphViewToPresenterProtocol: class {
    var view: GraphPresenterToViewProtocol? {get set}
    var interactor: GraphPresenterToInteractorProtocol? {get set}
    var router: GraphPresenterToRouterProtocol? {get set}
    func fetchingAQMData(city: String)
    func unsubscribe()
}

protocol GraphPresenterToViewProtocol: class {
    func showAQMData(data: AQMCityDataModel?)
    func showError(error: String)
    func isLoading(isLoading: Bool)
}

protocol GraphPresenterToRouterProtocol: class {
    static func createModule()-> AQMGraphViewController
}

protocol GraphPresenterToInteractorProtocol: class {
    var presenter:GraphInteractorToPresenterProtocol? {get set}
    func fetchingAQMData(forCity: String)
    func unsubscribe()
}

protocol GraphInteractorToPresenterProtocol: class {
    func fetchedAQMSuccess(data: AQMCityDataModel?)
}
