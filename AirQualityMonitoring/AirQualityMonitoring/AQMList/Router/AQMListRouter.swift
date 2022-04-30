//
//  AQMListRouter.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 18/04/22.
//

import Foundation
import UIKit

class AQMListRouter: PresenterToRouterProtocol {
    static func createModule() -> AQMListViewController {
        let controller:AQMListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AQMListVC") as! AQMListViewController
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = AQMListPresenter()
        let interactor: PresenterToInteractorProtocol = AQMListInteractor()
        let router:PresenterToRouterProtocol = AQMListRouter()
        
        controller.presentor = presenter
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return controller
    }
    
    func showGraphController(navigationController: UINavigationController, AQMCityData: AQMCityDataModel) {
        let graphModule = AQMGraphRouter.createModule()
        graphModule.cityModel = AQMCityData
        navigationController.pushViewController(graphModule, animated: true)
    }
    
    func showQuideController(sender: UIBarButtonItem, delegate: AQMListViewController) {
        let graphModule = AQMQuideRouter.createModule()
        graphModule.preferredContentSize = CGSize(width: Int(graphModule.view.frame.width) - 30, height: (AQMIndexClassification.allCases.count) * 60 + 5)
        graphModule.modalPresentationStyle = .popover
        let popoverVC = graphModule.popoverPresentationController
        popoverVC?.barButtonItem = sender
        popoverVC?.delegate = delegate
        popoverVC?.permittedArrowDirections = .any
        delegate.present(graphModule, animated: true, completion: nil)
    }
}
