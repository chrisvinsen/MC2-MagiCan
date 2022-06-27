//
//  StatistikKeuntunganView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 21/06/22.
//

import UIKit

class StatistikKeuntunganView: UIView {

    var statsExist: Bool
    var isUntung: Bool
    
    lazy var titleLabel = UILabel()
    lazy var dividerLine = UIView()
    lazy var totalKeuntunganLabel = UILabel()
    lazy var totalKeuntunganValue = UILabel()
    
    lazy var riwayatTransaksiLabel = UILabel()
    lazy var cardEmptyStats = CardEmptyStateStatistik()
    lazy var riwayatTable = UITableView()
    
    init(stats: Bool = true, untung: Bool = false) {
        statsExist = stats
        isUntung = untung
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
            [titleLabel, dividerLine, totalKeuntunganLabel, totalKeuntunganValue, riwayatTransaksiLabel, riwayatTable]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        case false:
            [titleLabel, dividerLine, totalKeuntunganLabel, totalKeuntunganValue, cardEmptyStats]
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
        
        titleLabel.text = "Statistik Keuntungan"
        totalKeuntunganLabel.text = "Total Keuntungan"
        totalKeuntunganValue.text = "Rp 0"
        riwayatTransaksiLabel.text = "Riwayat Transaksi"
        
        titleLabel.font = Font.largeTitle.getUIFont
        totalKeuntunganLabel.font = Font.textSemiBold.getUIFont
        totalKeuntunganValue.font = Font.headingFive.getUIFont
        riwayatTransaksiLabel.font = Font.headingSix.getUIFont
        
        dividerLine.backgroundColor = UIColor.Neutral._30
        totalKeuntunganValue.textColor = UIColor.Primary._30
        
        if !isUntung {
            titleLabel.text = "Statistik Kerugian"
            totalKeuntunganLabel.text = "Total Kerugian"
            totalKeuntunganValue.textColor = UIColor.Error._30
        }
        
        // edit text inside cardEmptyStats
        cardEmptyStats.sectionDescription1.text = "Belum  Ada Data Keuntungan Pada Periode Ini"
        cardEmptyStats.sectionDescription2.text = "Kamu bisa melihat grafik setelah ada transaksi yang tercatat pada periode ini minimal 1 minggu terakhir"
        
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
            
            totalKeuntunganLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 20),
            totalKeuntunganLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            totalKeuntunganValue.topAnchor.constraint(equalTo: totalKeuntunganLabel.bottomAnchor, constant: 10),
            totalKeuntunganValue.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
        ])
        
        switch statsExist {
        case true:
            NSLayoutConstraint.activate([
                riwayatTransaksiLabel.topAnchor.constraint(equalTo: totalKeuntunganValue.bottomAnchor, constant: 30),
                riwayatTransaksiLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                riwayatTransaksiLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
                
                riwayatTable.topAnchor.constraint(equalTo: riwayatTransaksiLabel.bottomAnchor, constant: 30),
                riwayatTable.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                riwayatTable.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
                riwayatTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
        case false:
            NSLayoutConstraint.activate([
                cardEmptyStats.topAnchor.constraint(equalTo: totalKeuntunganValue.bottomAnchor, constant: 30),
                cardEmptyStats.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                cardEmptyStats.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
            ])
        }
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikKeuntunganView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikKeuntunganView().showPreview().previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
#endif
