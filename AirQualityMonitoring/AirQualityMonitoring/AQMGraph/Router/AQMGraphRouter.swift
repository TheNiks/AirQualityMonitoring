//
//  AQMGraphRouter.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 20/04/22.
//

import Foundation
import UIKit

class AQMGraphRouter: GraphPresenterToRouterProtocol {
    static func createModule() -> AQMGraphViewController {
        let controller:AQMGraphViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AQMGraphVC") as! AQMGraphViewController
        let presenter: GraphViewToPresenterProtocol & GraphInteractorToPresenterProtocol = AQMGraphPresenter()
        let interactor: GraphPresenterToInteractorProtocol = AQMGraphInteractor()
        let router:GraphPresenterToRouterProtocol = AQMGraphRouter()
        
        controller.presentor = presenter
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return controller
    }
}
