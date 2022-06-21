//
//  DashboardView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import UIKit

class DashboardView: UIView {
    
    let titleLabel = HeadingFiveLabel()
    let cardKasUsaha = CardKasUsaha()
    let sectionPrediksiPenjualan = CardEmptyStateDashboard()
    let sectionMenuAndalan = CardEmptyStateDashboard()

    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpData()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [titleLabel, cardKasUsaha, sectionPrediksiPenjualan, sectionMenuAndalan]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpData() {
        // data for section - prediction
        sectionPrediksiPenjualan.sectionLabel.text = "Prediksi Penjualan"
        sectionPrediksiPenjualan.sectionDescription1.text = "Data Kamu Masih Belum Mencukupi"
        sectionPrediksiPenjualan.sectionDescription2.text = "Hasil prediksi penjualan akan muncul disini setelah data tersedia minimal 1 bulan terakhir"
        sectionPrediksiPenjualan.sectionImage.image = UIImage(named: "Prediksi Empty.png")
        
        // data for section - menu andalan
        sectionMenuAndalan.sectionLabel.text = "Menu Andalan"
        sectionMenuAndalan.sectionDescription1.text = "Menu Andalan Belum Tersedia"
        sectionMenuAndalan.sectionDescription2.text = "Hasil menu andalan akan muncul disini setelah data tersedia minimal 1 bulan terakhir"
        sectionMenuAndalan.sectionImage.image = UIImage(named: "Menu Andalan Empty.png")
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        titleLabel.text = "Selamat datang, XXX"
        
        // shadow for cardKasUsaha
        cardKasUsaha.layer.masksToBounds = false
        cardKasUsaha.layer.shadowColor = UIColor.black.cgColor
        cardKasUsaha.layer.shadowOpacity = 0.2
        cardKasUsaha.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cardKasUsaha.layer.shadowRadius = 10
        
        // shadow for sectionPrediksiPenjualan
        sectionPrediksiPenjualan.layer.masksToBounds = false
        sectionPrediksiPenjualan.layer.shadowColor = UIColor.black.cgColor
        sectionPrediksiPenjualan.layer.shadowOpacity = 0.2
        sectionPrediksiPenjualan.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        sectionPrediksiPenjualan.layer.shadowRadius = 10
        
        // shadow for sectionMenuAndalan
        sectionMenuAndalan.layer.masksToBounds = false
        sectionMenuAndalan.layer.shadowColor = UIColor.black.cgColor
        sectionMenuAndalan.layer.shadowOpacity = 0.2
        sectionMenuAndalan.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        sectionMenuAndalan.layer.shadowRadius = 10
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            cardKasUsaha.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            cardKasUsaha.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            cardKasUsaha.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            sectionPrediksiPenjualan.topAnchor.constraint(equalTo: cardKasUsaha.bottomAnchor, constant: 30),
            sectionPrediksiPenjualan.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            sectionPrediksiPenjualan.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            sectionMenuAndalan.topAnchor.constraint(equalTo: sectionPrediksiPenjualan.bottomAnchor, constant: 30),
            sectionMenuAndalan.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            sectionMenuAndalan.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),

        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct Dashboard_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            DashboardView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
