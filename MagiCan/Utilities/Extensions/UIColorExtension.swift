//
//  UIColorExtension.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 16/06/22.
//

import Foundation
import UIKit

extension UIColor {
    struct Neutral {
        static var _90: UIColor  { return UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1) }
        static var _70: UIColor { return UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1) }
        static var _50: UIColor { return UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1) }
        static var _30: UIColor { return UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1) }
        static var _10: UIColor { return UIColor(red: 240/250, green: 240/255, blue: 240/255, alpha: 1) }
    }
    
    struct Primary {
        static var _90: UIColor  { return UIColor(red: 15/255, green: 59/255, blue: 100/255, alpha: 1) }
        static var _70: UIColor { return UIColor(red: 20/255, green: 77/255, blue: 129/255, alpha: 1) }
        static var _50: UIColor { return UIColor(red: 22/255, green: 85/255, blue: 143/255, alpha: 1) }
        static var _30: UIColor { return UIColor(red: 69/255, green: 119/255, blue: 165/255, alpha: 1) }
        static var _30_15: UIColor { return UIColor(red: 69/255, green: 119/255, blue: 165/255, alpha: 0.15) }
        static var _10: UIColor { return UIColor(red: 162/250, green: 187/255, blue: 210/255, alpha: 1) }
    }
    
    struct Secondary {
        static var _90: UIColor  { return UIColor(red: 181/255, green: 136/255, blue: 57/255, alpha: 1) }
        static var _70: UIColor { return UIColor(red: 203/255, green: 153/255, blue: 65/255, alpha: 1) }
        static var _50: UIColor { return UIColor(red: 236/255, green: 167/255, blue: 44/255, alpha: 1) }
        static var _30: UIColor { return UIColor(red: 230/255, green: 187/255, blue: 103/255, alpha: 1) }
        static var _10: UIColor { return UIColor(red: 250/250, green: 243/255, blue: 201/255, alpha: 1) }
    }
    
    struct Success {
        static var _90: UIColor  { return UIColor(red: 59/255, green: 135/255, blue: 110/255, alpha: 1) }
        static var _70: UIColor { return UIColor(red: 78/255, green: 173/255, blue: 141/255, alpha: 1) }
        static var _50: UIColor { return UIColor(red: 0/255, green: 196/255, blue: 154/255, alpha: 1) }
        static var _30: UIColor { return UIColor(red: 95/255, green: 199/255, blue: 166/255, alpha: 1) }
        static var _10: UIColor { return UIColor(red: 133/250, green: 218/255, blue: 195/255, alpha: 1) }
    }
    
    struct Warning {
        static var _90: UIColor  { return UIColor(red: 171/255, green: 159/255, blue: 89/255, alpha: 1) }
        static var _70: UIColor { return UIColor(red: 220/255, green: 204/255, blue: 113/255, alpha: 1) }
        static var _50: UIColor { return UIColor(red: 248/255, green: 225/255, blue: 108/255, alpha: 1) }
        static var _30: UIColor { return UIColor(red: 245/255, green: 228/255, blue: 138/255, alpha: 1) }
        static var _10: UIColor { return UIColor(red: 250/250, green: 243/255, blue: 201/255, alpha: 1) }
    }
    
    struct Error {
        static var _90: UIColor  { return UIColor(red: 141/255, green: 49/255, blue: 58/255, alpha: 1) }
        static var _70: UIColor { return UIColor(red: 188/255, green: 65/255, blue: 77/255, alpha: 1) }
        static var _50: UIColor { return UIColor(red: 235/255, green: 81/255, blue: 96/255, alpha: 1) }
        static var _30: UIColor { return UIColor(red: 239/255, green: 116/255, blue: 128/255, alpha: 1) }
        static var _10: UIColor { return UIColor(red: 247/250, green: 185/255, blue: 191/255, alpha: 1) }
    }
}
