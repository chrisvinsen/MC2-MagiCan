//
//  StatistikKeuntunganView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 21/06/22.
//

import UIKit

class StatistikKeuntunganView: UIView {

    var statsExist = false
    
    lazy var titleLabel = UILabel()
    lazy var dividerLine = UIView()
    lazy var totalPemasukaLabel = UILabel()
    lazy var totalPemasukaValue = UILabel()
    
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
        [titleLabel, dividerLine, totalPemasukaLabel, totalPemasukaValue, cardEmptyStats]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        titleLabel.text = "Statistik Keuntungan"
        totalPemasukaLabel.text = "Total Keuntungan"
        totalPemasukaValue.text = "Rp 0"
        
        titleLabel.font = Font.largeTitle.getUIFont
        totalPemasukaLabel.font = Font.textSemiBold.getUIFont
        totalPemasukaValue.font = Font.headingFive.getUIFont
        
        dividerLine.backgroundColor = UIColor.Neutral._30
        totalPemasukaValue.textColor = UIColor.Primary._30
        
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
            
            totalPemasukaLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 20),
            totalPemasukaLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            totalPemasukaValue.topAnchor.constraint(equalTo: totalPemasukaLabel.bottomAnchor, constant: 10),
            totalPemasukaValue.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            cardEmptyStats.topAnchor.constraint(equalTo: totalPemasukaValue.bottomAnchor, constant: 30),
            cardEmptyStats.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            cardEmptyStats.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
        ])
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikKeuntunganView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikKeuntunganView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
