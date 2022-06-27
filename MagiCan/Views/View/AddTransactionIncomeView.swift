//
//  AddTransactionIncomeView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import Foundation
import UIKit

class AddTransactionIncomeView: UIView {
    
    lazy var titleLabel = UILabel()
    lazy var trxTypeButton = RowButton(label: "Jenis Pemasukan", value: "Pilih Jenis")
    lazy var tableView = UITableView()
    lazy var dateField = DateFieldView()
    lazy var descriptionField = DescriptionTextView()
    lazy var saveButton = PrimaryButton()
    
    init() {
        super.init(frame: .zero)
        
        tableView.register(ChooseMenuCell.self, forCellReuseIdentifier: "ChooseMenuCell")
        tableView.register(ChosenMenuCell.self, forCellReuseIdentifier: "ChosenMenuCell")
        tableView.register(TextFieldWithCardCell.self, forCellReuseIdentifier: "TextFieldWithCardCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.Neutral._50.cgColor
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        [titleLabel, trxTypeButton, tableView, dateField, descriptionField, saveButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        // Title Label
        titleLabel.text = "Pemasukan #0001"
        titleLabel.font = Font.textRegular.getUIFont
        titleLabel.textColor = UIColor.Neutral._70
        
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
            tableView.topAnchor.constraint(equalTo: trxTypeButton.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 400),
            
            // Date Field
            dateField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 15),
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
struct AddTransactionIncomeView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            AddTransactionIncomeView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
