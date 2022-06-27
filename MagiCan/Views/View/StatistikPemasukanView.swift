//
//  StatistikPemasukanView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 21/06/22.
//

import UIKit

class StatistikPemasukanView: UIView {
    
    var statsExist: Bool
    
    lazy var titleLabel = UILabel()
    lazy var dividerLine = UIView()
    lazy var totalPemasukanLabel = UILabel()
    lazy var totalPemasukanValue = UILabel()
    
//    lazy var riwayatTable = RiwayatTransaksiTable()
    lazy var riwayatTransaksiLabel = UILabel()
    lazy var cardEmptyStats = CardEmptyStateStatistik()
    lazy var riwayatTable = UITableView()
    
    init(status: Bool = true) {
        statsExist = status
        super.init(frame: .zero)
        
        riwayatTable.register(RiwayatTransaksiTableViewCell.self, forCellReuseIdentifier: RiwayatTransaksiTableViewCell.identifier)
        riwayatTable.showsVerticalScrollIndicator = false
        riwayatTable.showsHorizontalScrollIndicator = false
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        switch statsExist {
        case true:
            [titleLabel, dividerLine, totalPemasukanLabel, totalPemasukanValue, riwayatTransaksiLabel, riwayatTable]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        case false:
            [titleLabel, dividerLine, totalPemasukanLabel, totalPemasukanValue, cardEmptyStats]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        titleLabel.text = "Statistik Pemasukan"
        totalPemasukanLabel.text = "Total Pemasukan"
        totalPemasukanValue.text = "Rp 0"
        riwayatTransaksiLabel.text = "Riwayat Transaksi"
        
        titleLabel.font = Font.largeTitle.getUIFont
        totalPemasukanLabel.font = Font.textSemiBold.getUIFont
        totalPemasukanValue.font = Font.headingFive.getUIFont
        riwayatTransaksiLabel.font = Font.headingSix.getUIFont
        
        dividerLine.backgroundColor = UIColor.Neutral._30
        totalPemasukanValue.textColor = UIColor.Primary._30
        
        // shadow for cardEmptyStats
        cardEmptyStats.layer.masksToBounds = false
        cardEmptyStats.layer.shadowColor = UIColor.gray.cgColor
        cardEmptyStats.layer.shadowOpacity = 0.2
        cardEmptyStats.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cardEmptyStats.layer.shadowRadius = 10
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dividerLine.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            dividerLine.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            
            totalPemasukanLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 20),
            totalPemasukanLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            totalPemasukanValue.topAnchor.constraint(equalTo: totalPemasukanLabel.bottomAnchor, constant: 10),
            totalPemasukanValue.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
        ])
        
        switch statsExist {
        case true:
            NSLayoutConstraint.activate([
                riwayatTransaksiLabel.topAnchor.constraint(equalTo: totalPemasukanValue.bottomAnchor, constant: 30),
                riwayatTransaksiLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                riwayatTransaksiLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
                
                riwayatTable.topAnchor.constraint(equalTo: riwayatTransaksiLabel.bottomAnchor, constant: 30),
                riwayatTable.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                riwayatTable.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
                riwayatTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
        case false:
            NSLayoutConstraint.activate([
                cardEmptyStats.topAnchor.constraint(equalTo: totalPemasukanValue.bottomAnchor, constant: 30),
                cardEmptyStats.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                cardEmptyStats.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
            ])
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikPemasukan_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikPemasukanView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
