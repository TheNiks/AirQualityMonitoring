//
//  AQMIndexClassifier.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import UIKit

/// Enum for Air Quality Monitor Index
enum AQMIndexClassification: String, CaseIterable {
    case good
    case satisfactory
    case moderate
    case poor
    case veryPoor = "very poor"
    case severe
    case outOfRange
}

class AQMIndexClassifier {
    /// Based on AQI range get AQI enum
    static func classifyAirQualityIndex(aqi: Float) -> AQMIndexClassification {
        switch aqi {
        case 0.00...50.99:
            return .good
        case 51.00...100.99:
            return .satisfactory
        case 101.00...200.99:
            return .moderate
        case 201.00...300.99:
            return .poor
        case 301.00...400.99:
            return .veryPoor
        case 401.00...500:
            return .severe
        default:
            return .outOfRange
        }
    }
}

struct AQMIndexColorClassifier {
    /// Based on AQI enum get color
    static func color(index: AQMIndexClassification) -> UIColor? {
        switch index {
        case .good:
            return UIColor(hex: "#4CA24E")
        case .satisfactory:
            return UIColor(hex: "#99C457")
        case .moderate:
            return UIColor(hex: "#FFFA50")
        case .poor:
            return UIColor(hex: "#EF8F40")
        case .veryPoor:
            return UIColor(hex: "#E52536")
        case .severe:
            return UIColor(hex: "#A51B27")
        case .outOfRange:
            return UIColor(hex: "#8B0000")
        }
    }
}
