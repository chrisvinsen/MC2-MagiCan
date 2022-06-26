//
//  StepperField.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit

class StepperField: UIView {
    
    var defaultValue: Int

    lazy var textField = UITextField()
    lazy var incrementButton = UIButton(type: .system)
    lazy var decrementButton = UIButton(type: .system)
    
    init(defaultValue: Int = 0) {
        self.defaultValue = defaultValue
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        [textField, incrementButton, decrementButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Neutral._50.cgColor
        
        // Text Field
        textField.keyboardType = .numberPad
        textField.font = Font.textRegularSemiBold.getUIFont
        textField.textColor = UIColor.Neutral._90
        textField.placeholder = "0"
        textField.text = String(defaultValue)
//        textField.backgroundColor = .red
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.Neutral._50.cgColor
        
        // Decrement Button
        decrementButton.setImage(UIImage(systemName: "minus"), for: .normal)
        decrementButton.tintColor = UIColor.Neutral._70
//        decrementButton.backgroundColor = .green
        decrementButton.layer.borderWidth = 1
        decrementButton.layer.borderColor = UIColor.Neutral._50.cgColor
        
        // Increment Button
        incrementButton.setImage(UIImage(systemName: "plus"), for: .normal)
        incrementButton.tintColor = UIColor.Neutral._70
//        incrementButton.backgroundColor = .green
        incrementButton.layer.borderWidth = 1
        incrementButton.layer.borderColor = UIColor.Neutral._50.cgColor
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 30),
            
            decrementButton.topAnchor.constraint(equalTo: self.topAnchor),
            decrementButton.widthAnchor.constraint(equalToConstant: 30),
            decrementButton.heightAnchor.constraint(equalToConstant: 30),
            decrementButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            // Text Field
            textField.heightAnchor.constraint(equalToConstant: 30),
//            textField.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            textField.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            textField.leftAnchor.constraint(equalTo: decrementButton.rightAnchor, constant: -1),
            textField.rightAnchor.constraint(equalTo: incrementButton.leftAnchor, constant: 1),
//            textField.topAnchor.constraint(equalTo: self.topAnchor),
//            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            textField.leftAnchor.constraint(equalTo: self.leftAnchor),
//            textField.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            // Decrement Button
//            decrementButton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            
            // Increment Button
            incrementButton.widthAnchor.constraint(equalToConstant: 30),
            incrementButton.heightAnchor.constraint(equalToConstant: 30),
            incrementButton.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            incrementButton.rightAnchor.constraint(equalTo: self.rightAnchor),
//            incrementButton.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: -1),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StepperField_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StepperField().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
