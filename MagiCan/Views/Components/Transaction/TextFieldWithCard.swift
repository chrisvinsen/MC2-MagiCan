//
//  TextFieldWithCard.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit

class TextFieldWithCard: UIView {
    
    var isEnabled: Bool
    var title, prefixValue, valuePlaceholder: String
    
    lazy var titleLabel = RegularLabel()
    lazy var prefixValueLabel = UILabel()
    lazy var textField = UITextField()
    lazy var divider = UIView()
    
    init(title: String = "Default Label", prefixValue: String = "Rp", valuePlaceholder: String = "0", isEnabled: Bool = true) {
        
        self.title = title
        self.prefixValue = prefixValue
        self.valuePlaceholder = valuePlaceholder
        self.isEnabled = isEnabled
        
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    private func addSubviews(){
        
        [titleLabel, prefixValueLabel, textField, divider]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Neutral._50.cgColor
        self.backgroundColor = .white
        
        // Title Label
        titleLabel.text = self.title
        titleLabel.font = Font.textBold.getUIFont
        titleLabel.textColor = UIColor.Neutral._90
        
        // Prefix Label
        prefixValueLabel.text = self.prefixValue
        prefixValueLabel.font = Font.headingSix.getUIFont
        prefixValueLabel.textColor = UIColor.Neutral._90
        prefixValueLabel.numberOfLines = 1
        
        // Text Field
        textField.attributedPlaceholder = NSAttributedString(
            string: self.valuePlaceholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.Neutral._50
            ]
        )
        textField.font = Font.headingSix.getUIFont
        textField.textColor = UIColor.Neutral._90
        
        // Divider
        divider.backgroundColor = UIColor.Neutral._50
    }
    
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            // Prefix Value Label
            prefixValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            prefixValueLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            prefixValueLabel.widthAnchor.constraint(equalToConstant: 35),
            
            // Text Field
            textField.centerYAnchor.constraint(equalTo: prefixValueLabel.centerYAnchor),
            textField.leftAnchor.constraint(equalTo: prefixValueLabel.rightAnchor, constant: 5),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            // Divider
            divider.topAnchor.constraint(equalTo: prefixValueLabel.bottomAnchor, constant: 10),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            divider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct TotalPemasukanView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            TextFieldWithCard().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
