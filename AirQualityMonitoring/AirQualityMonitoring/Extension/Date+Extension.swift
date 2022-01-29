//
//  Date+Extension.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 29/01/22.
//

import Foundation

extension Date {
    /// Get string representation value based on date
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
}
