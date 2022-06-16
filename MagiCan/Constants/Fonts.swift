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
    case textRegular
    case textRegularSemiBold
    
    case headingFive
    
    
    var getUIFont: UIFont {
        switch self {
        case .text:
            return UIFont(name: "Inter-Regular", size: 14)!
        case .textRegular:
            return UIFont(name: "Inter-Regular", size: 17)!
        case .textRegularSemiBold:
            return UIFont(name: "Inter-SemiBold", size: 17)!
        case .headingFive:
            return UIFont(name: "Inter-Bold", size: 24)!
        }
    }
}
