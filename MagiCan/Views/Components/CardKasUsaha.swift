//
//  CardTypeOne.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import Foundation
import UIKit

class CardTypeOne: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        lazy var cardLabel = HeadingFiveLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
