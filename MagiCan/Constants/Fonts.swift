//
//  Fonts.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 16/06/22.
//

import Foundation
import UIKit

enum Font {
    case text
    case textSemiBold
    case textBold
    case textRegular
    case textRegularSemiBold
    
    case headingFive
    case headingSix
    
    case small
    case extraSmall
    case subtitleSemiBold
    
    case largeTitle
    
    var getUIFont: UIFont {
        switch self {
        case .text:
            return UIFont(name: "Inter-Regular", size: 14)!
        case .textSemiBold:
            return UIFont(name: "Inter-SemiBold", size: 14)!
        case .textBold:
            return UIFont(name: "Inter-Bold", size: 14)!
        case .textRegular:
            return UIFont(name: "Inter-Regular", size: 17)!
        case .textRegularSemiBold:
            return UIFont(name: "Inter-SemiBold", size: 17)!
        case .headingFive:
            return UIFont(name: "Inter-Bold", size: 24)!
        case .headingSix:
            return UIFont(name: "Inter-SemiBold", size: 20)!
        case .small:
            return UIFont(name: "Inter-Regular", size: 12)!
        case .extraSmall:
            return UIFont(name: "Inter-Regular", size: 10)!
        case .subtitleSemiBold:
            return UIFont(name: "Inter-SemiBold", size: 16)!
        case .largeTitle:
            return UIFont(name: "Inter-Bold", size: 34)!
        }
    }
}
