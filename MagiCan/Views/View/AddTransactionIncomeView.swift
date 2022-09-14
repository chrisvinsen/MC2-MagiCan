//
//  AddTransactionIncomeView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import Foundation
import UIKit

class AddTransactionIncomeView: UIView {
    
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var stackView = UIStackView()
    
    lazy var titleLabel = UILabel()
    lazy var trxTypeButton = RowButton(label: "Sistem Pembelian", value: "Pilih Sistem")
    lazy var tableView = TableViewAdjustedHeight()
    lazy var dateField = DateFieldView()
    lazy var descriptionField = DescriptionTextView()
    lazy var saveButton = PrimaryButton()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
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
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        [titleLabel, tableView, trxTypeButton, dateField, descriptionField, saveButton]
        
            .forEach {
                stackView.addArrangedSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        self.backgroundColor = .white
        
        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        // Container
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.setCustomSpacing(30, after: descriptionField)
        
        // Title Label
        titleLabel.text = "Pemasukan #0001"
        titleLabel.font = Font.textRegular.getUIFont
        titleLabel.textColor = UIColor.Neutral._70
        
        // Table View
        tableView.isScrollEnabled = false
        
        // Save Button
        saveButton.setTitle("Simpan", for: .normal)
    }
    
    func setUpConstraints() {
        
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Stack View
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            // Table View
//            tableView.heightAnchor.constraint(equalToConstant: 500),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: trxTypeButton.topAnchor, constant: -20),
            
            // Save Button
            saveButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
//        let tableHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height)
//        tableHeightConstraint.priority = .defaultHigh
//        tableHeightConstraint.isActive = true
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
