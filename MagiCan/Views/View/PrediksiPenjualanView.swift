//
//  PrediksiPenjualanView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit

class PrediksiPenjualanView: UIView {

    var predExist: Bool
    
    lazy var titleLabel = UILabel()
    lazy var dividerLine = UIView()
    lazy var totalPemasukanLabel = UILabel()
    lazy var totalPemasukanValue = UILabel()
    
    lazy var prediksiTableLabel = UILabel()
    lazy var cardEmptyStats = CardEmptyStateStatistik()
    lazy var prediksiTable = UITableView()
    
    init(status: Bool = true) {
        predExist = status
        super.init(frame: .zero)
        
        prediksiTable.register(PrediksiJumlahMenuTableViewCell.self, forCellReuseIdentifier: PrediksiJumlahMenuTableViewCell.identifier)
        prediksiTable.showsVerticalScrollIndicator = false
        prediksiTable.showsHorizontalScrollIndicator = false
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        switch predExist {
        case true:
            [titleLabel, dividerLine, totalPemasukanLabel, totalPemasukanValue, prediksiTableLabel, prediksiTable]
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
        
        titleLabel.text = "Prediksi Penjualan"
        totalPemasukanLabel.text = "Total Pemasukan"
        totalPemasukanValue.text = "Rp 0"
        prediksiTableLabel.text = "Prediksi Jumlah Menu"
        
        titleLabel.font = Font.largeTitle.getUIFont
        totalPemasukanLabel.font = Font.textSemiBold.getUIFont
        totalPemasukanValue.font = Font.headingFive.getUIFont
        prediksiTableLabel.font = Font.headingSix.getUIFont
        
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
        
        switch predExist {
        case true:
            NSLayoutConstraint.activate([
                prediksiTableLabel.topAnchor.constraint(equalTo: totalPemasukanValue.bottomAnchor, constant: 30),
                prediksiTableLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                prediksiTableLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
                
                prediksiTable.topAnchor.constraint(equalTo: prediksiTableLabel.bottomAnchor, constant: 30),
                prediksiTable.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20)
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
struct PrediksiPenjualanView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            PrediksiPenjualanView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
