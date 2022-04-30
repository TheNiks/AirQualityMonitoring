//
//  AQMQuideRouter.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 21/04/22.
//

import Foundation
import UIKit

class AQMQuideRouter: QuidePresenterToRouterProtocol {
    static func createModule() -> AQMQuideViewController {
        let controller:AQMQuideViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AQMQuideVC") as! AQMQuideViewController
        let presenter: QuideViewToPresenterProtocol & QuideInteractorToPresenterProtocol = AQMQuidePresenter()
        let interactor: QuidePresenterToInteractorProtocol = AQMQuideInteractor()
        let router:QuidePresenterToRouterProtocol = AQMQuideRouter()
        
        controller.presentor = presenter
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return controller
    }
}
