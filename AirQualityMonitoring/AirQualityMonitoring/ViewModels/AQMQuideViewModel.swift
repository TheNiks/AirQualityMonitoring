//
//  AQMQuideViewModel.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import Foundation
import RxSwift
import RxCocoa

class AQMQuideViewModel {
    var rangeOffset = 50
    var indexRange = 50
    var aqmRecords = [AQMQuideModel]()
    /// Binding publish subject for recieving updates
    var items = PublishSubject<[AQMQuideModel]>()

    /// Prepare the records for Air Quality Monitor Index guide
    func setupAQMGuide() {
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
        items.onNext(aqmRecords)
    }
}

