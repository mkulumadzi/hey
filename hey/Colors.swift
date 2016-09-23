//
//  Colors.swift
//  Gabb
//
//  Created by Evan Waters on 3/25/16.
//  Copyright © 2016 Evan Waters. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    
    class func heyBlue() -> UIColor {
        return UIColor(hue: 186/360, saturation: 0.89, brightness: 1.0, alpha: 1.0)
    }
    
    class func heyGreen() -> UIColor {
        return UIColor(hue: 130/360, saturation: 0.53, brightness: 0.92, alpha: 1.0)
    }
    
    class func heyYellow() -> UIColor {
        return UIColor(hue: 67/360, saturation: 0.9, brightness: 1.0, alpha: 1.0)
    }
    
    class func heyOrange() -> UIColor {
        return UIColor(hue: 42/360, saturation: 0.91, brightness: 0.91, alpha: 1.0)
    }
    
    class func heyRed() -> UIColor {
        return UIColor(hue: 17/360, saturation: 0.92, brightness: 1.0, alpha: 1.0)
    }
    
    class func heyPurple() -> UIColor {
        return UIColor(hue: 300/360, saturation: 0.66, brightness: 1.0, alpha: 1.0)
    }
    
    class func darkYellow() -> UIColor {
        return UIColor(hue: 67/360, saturation: 0.9, brightness: 0.75, alpha: 1.0)
    }
    
    fileprivate class func colorComponentFrom(_ string: String, start: Int, length: Int) -> CGFloat {
        let index1 = string.characters.index(string.startIndex, offsetBy: start)
        let substring1 = string.substring(from: index1)
        
        let index2 = substring1.characters.index(substring1.startIndex, offsetBy: length)
        let substring2 = substring1.substring(to: index2)
        
        let fullHex = length == 2 ? substring2 : substring2 + substring2
        
        var hexString:CUnsignedInt = 0;
        Scanner.init(string: fullHex).scanHexInt32(&hexString)
        
        return CGFloat(hexString) / 255.0
    }
    
    fileprivate class func colorWithHexString(_ hexString: String) -> UIColor {
        let colorString = hexString.replacingOccurrences(of: "#", with: "")
        var alpha:CGFloat!
        var red:CGFloat!
        var blue:CGFloat!
        var green:CGFloat!
        
        switch (colorString.characters.count) {
        case 3: //#RGB
            alpha = 1.0
            red = UIColor.colorComponentFrom(colorString, start: 0, length: 1)
            green = UIColor.colorComponentFrom(colorString, start: 1, length: 1)
            blue = UIColor.colorComponentFrom(colorString, start: 2, length: 1)
            break
        case 4: //#ARGB
            alpha = UIColor.colorComponentFrom(colorString, start: 0, length: 1)
            red = UIColor.colorComponentFrom(colorString, start: 1, length: 1)
            green = UIColor.colorComponentFrom(colorString, start: 2, length: 1)
            blue = UIColor.colorComponentFrom(colorString, start: 3, length: 1)
            break
        case 6: // #RRGGBB
            alpha = 1.0
            red = UIColor.colorComponentFrom(colorString, start: 0, length: 2)
            green = UIColor.colorComponentFrom(colorString, start: 2, length: 2)
            blue = UIColor.colorComponentFrom(colorString, start: 2, length: 2)
            break
        case 8: // #RRGGBB
            alpha = UIColor.colorComponentFrom(colorString, start: 0, length: 2)
            red = UIColor.colorComponentFrom(colorString, start: 2, length: 2)
            green = UIColor.colorComponentFrom(colorString, start: 4, length: 2)
            blue = UIColor.colorComponentFrom(colorString, start: 4, length: 1)
            break
        default:
            NSException.raise(NSExceptionName(rawValue: "Invalid color value"), format: "Color value \(hexString) is invalid. It should be a hex value of the form #RGB, #ARGB, #RRGGBB, #AARRGGBB", arguments:getVaList(["nil"]))
            break
        }
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)

    }
    
}
