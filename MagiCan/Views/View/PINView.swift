//
//  PINView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation
import UIKit

class PINView: UIView {
    var headingText: String
    
    lazy var imageView = UIImageView()
    lazy var headingLabel = HeadingFiveLabel()
    lazy var PINField = UITextField()
    lazy var viewPINContainer = UIView()
    lazy var viewPIN1 = UIView()
    lazy var viewPIN2 = UIView()
    lazy var viewPIN3 = UIView()
    lazy var viewPIN4 = UIView()
    lazy var viewPIN5 = UIView()
    lazy var viewPIN6 = UIView()
    lazy var warningLabel = WarningLabel()
    
    var groupOfviewPIN = [UIView()]
    
    var pin: String = "" {
        didSet {
            for pinIndex in 0...5 {
                if pinIndex < pin.count {
                    groupOfviewPIN[pinIndex].backgroundColor = UIColor.Secondary._50
                } else {
                    groupOfviewPIN[pinIndex].backgroundColor = UIColor.Neutral._50
                }
            }
            
            if pin.count < 6 {
                warningLabel.text = ""
            }
        }
    }
    
    init(headingText: String = "Masukkan PIN") {
        self.headingText = headingText
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        groupOfviewPIN = [viewPIN1, viewPIN2, viewPIN3, viewPIN4, viewPIN5, viewPIN6]
        
        groupOfviewPIN
            .forEach {
                viewPINContainer.addSubview($0)
                $0.backgroundColor = UIColor.Neutral._50
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = true
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        [imageView, headingLabel, viewPINContainer, PINField, warningLabel]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.backgroundColor = .white
        
        // Image View
        imageView.image = UIImage(named: "PIN.png")
        imageView.contentMode = .scaleAspectFit
        
        // Heading Label
        headingLabel.text = headingText
        headingLabel.textAlignment = .center
        
        // PIN Text Field
        PINField.keyboardType = .numberPad
        PINField.becomeFirstResponder()
        PINField.tintColor = .white
        PINField.textColor = .white
        
        // Warning Label
        warningLabel.textAlignment = .center
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
//            Image View
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60),
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
//            Heading Label
            headingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            headingLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            headingLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
//            View PIN
            viewPINContainer.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 50),
            viewPINContainer.heightAnchor.constraint(equalToConstant: 20),
            viewPINContainer.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            viewPIN1.widthAnchor.constraint(equalToConstant: 20),
            viewPIN1.heightAnchor.constraint(equalToConstant: 20),
            viewPIN1.leadingAnchor.constraint(equalTo: viewPINContainer.leadingAnchor),
            
            viewPIN2.widthAnchor.constraint(equalToConstant: 20),
            viewPIN2.heightAnchor.constraint(equalToConstant: 20),
            viewPIN2.leadingAnchor.constraint(equalTo: viewPIN1.trailingAnchor, constant: 10),
            
            viewPIN3.widthAnchor.constraint(equalToConstant: 20),
            viewPIN3.heightAnchor.constraint(equalToConstant: 20),
            viewPIN3.leadingAnchor.constraint(equalTo: viewPIN2.trailingAnchor, constant: 10),
            
            viewPIN4.widthAnchor.constraint(equalToConstant: 20),
            viewPIN4.heightAnchor.constraint(equalToConstant: 20),
            viewPIN4.leadingAnchor.constraint(equalTo: viewPIN3.trailingAnchor, constant: 10),
            
            viewPIN5.widthAnchor.constraint(equalToConstant: 20),
            viewPIN5.heightAnchor.constraint(equalToConstant: 20),
            viewPIN5.leadingAnchor.constraint(equalTo: viewPIN4.trailingAnchor, constant: 10),
            
            viewPIN6.widthAnchor.constraint(equalToConstant: 20),
            viewPIN6.heightAnchor.constraint(equalToConstant: 20),
            viewPIN6.leadingAnchor.constraint(equalTo: viewPIN5.trailingAnchor, constant: 10),
            viewPIN6.trailingAnchor.constraint(equalTo: viewPINContainer.trailingAnchor),
            
//            PIN Field
            PINField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            PINField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            PINField.topAnchor.constraint(equalTo: safeArea.topAnchor),
            PINField.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            // Warning Label
            warningLabel.topAnchor.constraint(equalTo: viewPINContainer.bottomAnchor, constant: 20),
            warningLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PINView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            PINView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
