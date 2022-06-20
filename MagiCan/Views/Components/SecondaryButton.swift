//
//  SecondaryButton.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import Foundation
import UIKit

class SecondaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.titleLabel?.font = Font.textSemiBold.getUIFont
        
        self.backgroundColor = UIColor.Primary._30_15
        self.setTitleColor(UIColor.Primary._30, for: UIControl.State.normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

