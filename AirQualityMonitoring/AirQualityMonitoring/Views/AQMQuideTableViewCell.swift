//
//  AQMQuideTableViewCell.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 28/01/22.
//

import UIKit

class AQMQuideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblIndex: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    /// AQMQuideModel use didSet() for cell's UI representation
    var guideData: AQMQuideModel? {
        didSet {
            //Has data to represent the Air Quality Monitor Index information
            guard let guideData = guideData else { return }
            lblIndex.text = guideData.index
            lblCategory.text = guideData.category.rawValue.capitalized
            self.contentView.backgroundColor = guideData.color
        }
    }
}
