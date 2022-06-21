//
//  CardTypeOne.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import Foundation
import UIKit

class CardKasUsaha: UIView {
    
    lazy var kasLabel = RegularLabel()
    lazy var kasValue = HeadingFiveLabel()
    lazy var button = SecondaryButton()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [kasLabel, kasValue, button]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        kasLabel.text = "Kas Usaha"
        kasValue.text = "Rp 0"
        button.setTitle("Set Kas Usaha", for: .normal)
        button.contentEdgeInsets =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 90),
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
            kasLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            kasLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            kasValue.topAnchor.constraint(equalTo: kasLabel.bottomAnchor, constant: 10),
            kasValue.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            
            button.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15),
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CardKasUsaha_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            CardKasUsaha().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif