//
//  PrimaryButton.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation
import UIKit

class PrimaryButton: CustomButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.titleLabel?.font = Font.textRegularSemiBold.getUIFont
        
        self.setBackgroundColor(UIColor.Primary._30, for: .normal)
        self.setBackgroundColor(UIColor.Neutral._50, for: .disabled)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
