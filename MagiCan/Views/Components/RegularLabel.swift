//
//  RegularLabel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation
import UIKit

class RegularLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.numberOfLines = 0
        self.textColor = UIColor.Neutral._70
        self.font = UIFontMetrics.default.scaledFont(for: Font.textRegular.getUIFont)
        self.adjustsFontForContentSizeCategory = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
