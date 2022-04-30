//
//  AQMQuideProtocol.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 21/04/22.
//

import Foundation
import UIKit

protocol QuideViewToPresenterProtocol: class {
    var view: QuidePresenterToViewProtocol? {get set}
    var interactor: QuidePresenterToInteractorProtocol? {get set}
    var router: QuidePresenterToRouterProtocol? {get set}
    func fetchingAQMQuideData()
}

protocol QuidePresenterToViewProtocol: class {
    func showAQMGuideData(data: [AQMQuideModel])
    func showError(error: String)
    func isLoading(isLoading: Bool)
}

protocol QuidePresenterToRouterProtocol: class {
    static func createModule()-> AQMQuideViewController
}

protocol QuidePresenterToInteractorProtocol: class {
    var presenter:QuideInteractorToPresenterProtocol? {get set}
    func fetchingAQMQuideData()
}

protocol QuideInteractorToPresenterProtocol: class {
    func fetchedAQMSuccess(data: [AQMQuideModel])
}
