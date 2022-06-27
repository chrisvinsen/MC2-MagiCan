//
//  AddTransactionExpenseView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import Foundation
import UIKit

class AddTransactionExpenseView: UIView {
    
    lazy var titleLabel = UILabel()
    lazy var trxTypeButton = RowButton(label: "Jenis Pengeluaran", value: "Pilih Jenis")
    lazy var totalAmountField = TextFieldWithCard(title: "Total Pengeluaran", prefixValue: "Rp", valuePlaceholder: "0", isEnabled: true)
    lazy var dateField = DateFieldView()
    lazy var descriptionField = DescriptionTextView()
    lazy var saveButton = PrimaryButton()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        [titleLabel, trxTypeButton, totalAmountField, dateField, descriptionField, saveButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        // Title Label
        titleLabel.text = "Pengeluaran #0001"
        titleLabel.font = Font.textRegular.getUIFont
        titleLabel.textColor = UIColor.Neutral._70
        
        // Total Amount Field
        totalAmountField.textField.keyboardType = .numberPad
        
        // Save Button
        saveButton.setTitle("Simpan", for: .normal)
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            // Transaction Type Button
            trxTypeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            trxTypeButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            trxTypeButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            // Table View
            totalAmountField.topAnchor.constraint(equalTo: trxTypeButton.bottomAnchor, constant: 15),
            totalAmountField.leftAnchor.constraint(equalTo: self.leftAnchor),
            totalAmountField.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            // Date Field
            dateField.topAnchor.constraint(equalTo: totalAmountField.bottomAnchor, constant: 15),
            dateField.leftAnchor.constraint(equalTo: self.leftAnchor),
            dateField.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            // Description Field
            descriptionField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 15),
            descriptionField.leftAnchor.constraint(equalTo: self.leftAnchor),
            descriptionField.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            // Save Button
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            saveButton.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 30),
            saveButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AddTransactionExpenseView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            AddTransactionExpenseView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
