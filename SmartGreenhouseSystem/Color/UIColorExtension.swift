//
//  UIColorExtension.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 21.11.2020.
//

import UIKit

extension UIColor {

    public class func appColor() -> UIColor {
        return UIColor(netHex: 0x46658E)
    }
    
    public class func signInBuutonColor() -> UIColor {
        return UIColor(netHex: 0x4A90E2)
    }
    
    public class func tabBarTitleColor() -> UIColor {
        return UIColor(netHex: 0xF5A623)
    }
    
    public class func popUpColor() -> UIColor {
        return UIColor(netHex: 0x40D4B5)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid Red")
        assert(green >= 0 && green <= 255, "Invalid Green")
        assert(blue >= 0 && blue <= 255, "Invalid Blue")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
