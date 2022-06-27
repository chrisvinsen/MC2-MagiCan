//
//  DashboardView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import UIKit

class DashboardView: UIScrollView {
    
    var predictionAndMenuAvaiable: Bool
    
    let titleLabel = UILabel()
    let profileIcon = UIImageView()
    let cardKasUsaha = CardKasUsaha()
    let carouselStatistik = Carousel()
    
    let sectionPrediksiPenjualan = CardEmptyStateDashboard()
    let sectionMenuAndalan = CardEmptyStateDashboard()
    
    let sectionPrediksiPenjualanFilled = CardPrediksiPenjualan()
    let sectionMenuAndalanFilled = CardMenuAndalan()
    
    init(status: Bool = false) {
        predictionAndMenuAvaiable = status
        super.init(frame: .zero)
        
        addSubviews()
        setUpData()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        self.isScrollEnabled = true
        self.contentSize = CGSize(width:400, height: 2300)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        switch predictionAndMenuAvaiable {
        case true:
            [titleLabel, profileIcon, cardKasUsaha, carouselStatistik, sectionPrediksiPenjualanFilled, sectionMenuAndalanFilled]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        case false:
            [titleLabel, profileIcon, cardKasUsaha, carouselStatistik, sectionPrediksiPenjualan, sectionMenuAndalan]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
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
        self.backgroundColor = .white
        
        titleLabel.font = Font.headingSix.getUIFont
        titleLabel.text = "Selamat datang, XXX"
        
        profileIcon.image = UIImage(named: "Profile Icon.png")
        
        // shadow for cardKasUsaha
        cardKasUsaha.layer.masksToBounds = false
        cardKasUsaha.layer.shadowColor = UIColor.gray.cgColor
        cardKasUsaha.layer.shadowOpacity = 0.2
        cardKasUsaha.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cardKasUsaha.layer.shadowRadius = 10
        
        // shadow for sectionPrediksiPenjualan
        sectionPrediksiPenjualan.layer.masksToBounds = false
        sectionPrediksiPenjualan.layer.shadowColor = UIColor.gray.cgColor
        sectionPrediksiPenjualan.layer.shadowOpacity = 0.2
        sectionPrediksiPenjualan.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        sectionPrediksiPenjualan.layer.shadowRadius = 10
        
        // shadow for sectionMenuAndalan
        sectionMenuAndalan.layer.masksToBounds = false
        sectionMenuAndalan.layer.shadowColor = UIColor.gray.cgColor
        sectionMenuAndalan.layer.shadowOpacity = 0.2
        sectionMenuAndalan.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        sectionMenuAndalan.layer.shadowRadius = 10
        
        // shadow for sectionPrediksiPenjualanFilled
        sectionPrediksiPenjualanFilled.layer.masksToBounds = false
        sectionPrediksiPenjualanFilled.layer.shadowColor = UIColor.gray.cgColor
        sectionPrediksiPenjualanFilled.layer.shadowOpacity = 0.2
        sectionPrediksiPenjualanFilled.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        sectionPrediksiPenjualanFilled.layer.shadowRadius = 10
        
        // shadow for sectionMenuAndalanFilled
        sectionMenuAndalanFilled.layer.masksToBounds = false
        sectionMenuAndalanFilled.layer.shadowColor = UIColor.gray.cgColor
        sectionMenuAndalanFilled.layer.shadowOpacity = 0.2
        sectionMenuAndalanFilled.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        sectionMenuAndalanFilled.layer.shadowRadius = 10
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            profileIcon.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            profileIcon.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            cardKasUsaha.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            cardKasUsaha.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            cardKasUsaha.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            carouselStatistik.topAnchor.constraint(equalTo: cardKasUsaha.bottomAnchor, constant: 10),
            carouselStatistik.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            carouselStatistik.heightAnchor.constraint(equalToConstant: 150),
            carouselStatistik.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
        ])
        
        switch predictionAndMenuAvaiable {
        case true:
            NSLayoutConstraint.activate([
                sectionPrediksiPenjualanFilled.topAnchor.constraint(equalTo: carouselStatistik.bottomAnchor, constant: 30),
                sectionPrediksiPenjualanFilled.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                sectionPrediksiPenjualanFilled.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
                
                sectionMenuAndalanFilled.topAnchor.constraint(equalTo: sectionPrediksiPenjualanFilled.bottomAnchor, constant: 30),
                sectionMenuAndalanFilled.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                sectionMenuAndalanFilled.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
            ])
        case false:
            NSLayoutConstraint.activate([
                sectionPrediksiPenjualan.topAnchor.constraint(equalTo: carouselStatistik.bottomAnchor, constant: 30),
                sectionPrediksiPenjualan.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                sectionPrediksiPenjualan.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
                
                sectionMenuAndalan.topAnchor.constraint(equalTo: sectionPrediksiPenjualan.bottomAnchor, constant: 30),
                sectionMenuAndalan.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                sectionMenuAndalan.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
            ])
        }
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
