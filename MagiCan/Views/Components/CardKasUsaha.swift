//
//  CardTypeOne.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import Foundation
import UIKit

class CardKasUsaha: UIView {
    
    var kasIsSet: Bool = false {
        didSet {
            print("disini kas is set", kasIsSet)
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
            addSubviews()
            setUpViews()
            setUpConstraints()
        }
    }
    
    lazy var kasLabel = RegularLabel()
    lazy var kasValue = UILabel()
    lazy var button = SecondaryButton()
    lazy var editButton = UIButton()
//    lazy var editIcon = UIImageView()
    
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
        switch kasIsSet {
        case true:
            [kasLabel, kasValue, editButton]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        case false:
            [kasLabel, kasValue, button]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        kasValue.font = Font.headingSix.getUIFont
        
        kasLabel.text = "Kas Usaha"
        kasValue.text = "Rp 0"
        button.setTitle("Set Kas Usaha", for: .normal)
        button.contentEdgeInsets =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
//        editIcon.image = UIImage(named: "Edit Kas.png")
        
        let icon = UIImage(named: "Edit Kas.png")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        editButton.setBackgroundImage(icon, for: .normal)
        editButton.frame = iconSize
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
            
//            button.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
//            button.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15),
            
        ])
        
        switch kasIsSet {
        case true:
            NSLayoutConstraint.activate([
                editButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
                editButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15)
//                editIcon.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
//                editIcon.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15)
            ])
        case false:
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
                button.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15)
            ])
        }
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
