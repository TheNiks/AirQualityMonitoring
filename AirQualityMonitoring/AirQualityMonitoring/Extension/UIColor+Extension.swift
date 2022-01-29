//
//  UIColor+Extension.swift
//  AirQualityMonitoring
//
//  Created by Nikunj Modi on 29/01/22.
//

import UIKit

//UIColor extension
extension UIColor {
    //From hex string get UIColor
    public convenience init?(hex: String) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        var hexColor = hex
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        }
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if hexColor.count == 8 {
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
            }
        } else if hexColor.count == 6 {
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255
            }
        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
