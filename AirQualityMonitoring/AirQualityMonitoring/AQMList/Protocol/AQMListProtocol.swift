//
//  AQMListProtocol.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 18/04/22.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchingAQMData()
    func unsubscribe()
    func showAQMGraphViewController(navigationController: UINavigationController, AQMCityData: AQMCityDataModel)
    func showQuideController(sender: UIBarButtonItem, delegate: AQMListViewController)
}

protocol PresenterToViewProtocol: class{
    func showAQMData(data: [AQMCityDataModel]?)
    func showError(error: String)
    func isLoading(isLoading: Bool)
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> AQMListViewController
    func showGraphController(navigationController: UINavigationController, AQMCityData: AQMCityDataModel)
    func showQuideController(sender: UIBarButtonItem, delegate: AQMListViewController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchingAQMData()
    func unsubscribe()
}

protocol InteractorToPresenterProtocol: class {
    func fetchedAQMSuccess(data: [AQMCityDataModel]?)
    func fetchFailed(error: String)
    func isLoading(isLoading: Bool)
}

