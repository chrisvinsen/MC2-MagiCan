//
//  StatistikPengeluaranView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 21/06/22.
//

import UIKit

class StatistikPengeluaranView: UIView {

    var statsExist = true
    
    lazy var titleLabel = UILabel()
    lazy var dividerLine = UIView()
    lazy var totalPemasukaLabel = UILabel()
    lazy var totalPemasukaValue = UILabel()
    
    lazy var riwayatTransaksiLabel = UILabel()
    lazy var cardEmptyStats = CardEmptyStateStatistik()
    
    init() {
        super.init(frame: .zero)
        
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
            [titleLabel, dividerLine, totalPemasukaLabel, totalPemasukaValue, riwayatTransaksiLabel]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        case false:
            [titleLabel, dividerLine, totalPemasukaLabel, totalPemasukaValue, cardEmptyStats]
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
        
        titleLabel.text = "Statistik Pengeluaran"
        totalPemasukaLabel.text = "Total Pengeluaran"
        totalPemasukaValue.text = "Rp 0"
        riwayatTransaksiLabel.text = "Riwayat Transaksi"
        
        titleLabel.font = Font.largeTitle.getUIFont
        totalPemasukaLabel.font = Font.textSemiBold.getUIFont
        totalPemasukaValue.font = Font.headingFive.getUIFont
        riwayatTransaksiLabel.font = Font.headingSix.getUIFont
        
        dividerLine.backgroundColor = UIColor.Neutral._30
        totalPemasukaValue.textColor = UIColor.Error._30
        
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
            
            totalPemasukaLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 20),
            totalPemasukaLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            totalPemasukaValue.topAnchor.constraint(equalTo: totalPemasukaLabel.bottomAnchor, constant: 10),
            totalPemasukaValue.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
        ])
        
        switch statsExist {
        case true:
            NSLayoutConstraint.activate([
                riwayatTransaksiLabel.topAnchor.constraint(equalTo: totalPemasukaValue.bottomAnchor, constant: 30),
                riwayatTransaksiLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                riwayatTransaksiLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
            ])
        case false:
            NSLayoutConstraint.activate([
                cardEmptyStats.topAnchor.constraint(equalTo: totalPemasukaValue.bottomAnchor, constant: 30),
                cardEmptyStats.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                cardEmptyStats.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
            ])
        }
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikPengeluaranView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikPengeluaranView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
