//
//  TransactionListView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import UIKit

class TransactionListView: UIView {

    lazy var containerSummaryCard = UIView()
    lazy var summaryCard = CardTransactionView()
    lazy var tableView = UITableView()
    lazy var titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        containerSummaryCard.addSubview(summaryCard)
        
        self.addSubview(containerSummaryCard)
        self.addSubview(titleLabel)
        self.addSubview(tableView)
    }
    
    private func setUpViews() {
        
        self.backgroundColor = .white
        
        // Summary Card
        summaryCard.translatesAutoresizingMaskIntoConstraints = false
        summaryCard.layer.cornerRadius = 12
        summaryCard.layer.masksToBounds = true
        
        // Container Summary Card
        containerSummaryCard.translatesAutoresizingMaskIntoConstraints = false
        containerSummaryCard.layer.masksToBounds = false
        containerSummaryCard.layer.shadowColor = UIColor.gray.cgColor
        containerSummaryCard.layer.shadowOpacity = 0.2
        containerSummaryCard.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        containerSummaryCard.layer.shadowRadius = 10
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Riwayat Transaksi"
        titleLabel.font = Font.headingSix.getUIFont
        titleLabel.textColor = UIColor.Neutral._90
        
        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Summary Card
            summaryCard.topAnchor.constraint(equalTo: containerSummaryCard.topAnchor),
            summaryCard.bottomAnchor.constraint(equalTo: containerSummaryCard.bottomAnchor),
            summaryCard.leftAnchor.constraint(equalTo: containerSummaryCard.leftAnchor),
            summaryCard.rightAnchor.constraint(equalTo: containerSummaryCard.rightAnchor),
            
            // Container Summary Card
            containerSummaryCard.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            containerSummaryCard.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15),
            containerSummaryCard.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: containerSummaryCard.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 20),
            
            // Table View
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct TransactionListView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            TransactionListView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
