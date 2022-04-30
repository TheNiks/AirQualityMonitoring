//
//  AQMQuideInteractor.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 21/04/22.
//

import Foundation
import RxSwift

class AQMQuideInteractor : QuidePresenterToInteractorProtocol {
    var presenter: QuideInteractorToPresenterProtocol?
    var rangeOffset = 50
    var indexRange = 50
    var aqmRecords = [AQMQuideModel]()
    
    init() {}
    
    func fetchingAQMQuideData() {
        for (index, element) in AQMIndexClassification.allCases.enumerated() {
            /// Fetch the color based on AQMIndexClassification case
            if let backgroundColor = AQMIndexColorClassifier.color(index: element) {
                let firstIndex = index == 0 ? 0 : indexRange-rangeOffset + 1
                aqmRecords.append(AQMQuideModel(index: "\(firstIndex)-\(indexRange)", category: element, color: backgroundColor))
            }
            rangeOffset = index > 0 ? 100 : 50
            indexRange += rangeOffset
            
        }
        aqmRecords.removeLast()
        presenter?.fetchedAQMSuccess(data: aqmRecords)
    }
}
