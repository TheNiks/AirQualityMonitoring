//
//  AQMCityDataTableViewCell.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import UIKit

class AQMCityDataTableViewCell: UITableViewCell {
    
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var lblAQI: UILabel!
    @IBOutlet var lblLastUpdated: UILabel!
    @IBOutlet var backgroundContentView: UIView!

    /// First life cycle method to be called
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets.zero
    }

    /// CityDataModel use didSet() for cell's UI representation
    var cityData: AQMCityDataModel? {
        didSet {
            guard let cityData = cityData else { return }
            lblCity.text = cityData.city
            /// Set background color to clear until new color is calculated based on AQI value or if not found than due to previous colour it's reset.
            self.contentView.backgroundColor = UIColor.clear
            backgroundContentView.backgroundColor = UIColor.clear
            if let aqi = cityData.history.last?.value {
                lblAQI.text = String(format: "%.2f", aqi)
                let index = AQMIndexClassifier.classifyAirQualityIndex(aqi: aqi)
                if let backgroundColor = AQMIndexColorClassifier.color(index: index) {
                    backgroundContentView.backgroundColor = backgroundColor
                }
            }
            /// Has city's history last data
            if let date = cityData.history.last?.date {
                /// Set date value
                if date.timeAgo() == "0 seconds" {
                    lblLastUpdated.text = "just now"
                } else {
                    lblLastUpdated.text = date.timeAgo() + " ago"
                }
            }
            /// Use in UITest for table view cell
            self.accessibilityLabel = cityData.city
            self.accessibilityIdentifier = cityData.city
            self.accessibilityTraits = [.button]
        }
    }
}


