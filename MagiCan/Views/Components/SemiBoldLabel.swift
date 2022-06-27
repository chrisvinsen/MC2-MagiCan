//
//  SemiBoldLabel.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import UIKit

class SemiBoldLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.numberOfLines = 0
        self.textColor = UIColor.Neutral._90
        self.font = UIFontMetrics.default.scaledFont(for: Font.textSemiBold.getUIFont)
        self.adjustsFontForContentSizeCategory = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
