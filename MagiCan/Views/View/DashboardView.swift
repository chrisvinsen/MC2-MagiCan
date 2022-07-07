//
//  DashboardView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import UIKit

class DashboardView: UIView {
    
    var isPredictionExists: Bool = false
    var isTopMenuExists: Bool = false {
        didSet {
            if isTopMenuExists {
                sectionMenuAndalan.isHidden = true
                sectionMenuAndalanFilled.isHidden = false
                
                if menuAndalan.count >= 1  {
                    sectionMenuAndalanFilled.menu1.menuName.text = menuAndalan[0].name
                    sectionMenuAndalanFilled.menu1.menuQty.text = "\(menuAndalan[0].qty)x"
                    
                    var image = menuAndalan[0].imageUrl.imageFromBase64
                    if image == nil {
                        image = ImageMenuDefault!
                    }
                    
                    sectionMenuAndalanFilled.menu1.menuImage.image = image
                }
                
                if menuAndalan.count >= 2 {
                    sectionMenuAndalanFilled.menu2.menuName.text = menuAndalan[1].name
                    sectionMenuAndalanFilled.menu2.menuQty.text = "\(menuAndalan[1].qty)x"
                    

                    var image = menuAndalan[1].imageUrl.imageFromBase64
                    if image == nil {
                        image = ImageMenuDefault!
                    }
                    
                    sectionMenuAndalanFilled.menu2.menuImage.image = image
                }
                
                if menuAndalan.count >= 3 {
                    sectionMenuAndalanFilled.menu3.menuName.text = menuAndalan[2].name
                    sectionMenuAndalanFilled.menu3.menuQty.text = "\(menuAndalan[2].qty)x"
                    
                    var image = menuAndalan[2].imageUrl.imageFromBase64
                    if image == nil {
                        image = ImageMenuDefault!
                    }
                    
                    sectionMenuAndalanFilled.menu3.menuImage.image = image
                }
                
                
            } else {
                sectionMenuAndalan.isHidden = false
                sectionMenuAndalanFilled.isHidden = true
            }
        }
    }
    var kasIsSet: Bool = false
    var menuAndalan: [MenuAndalan] = [] {
        didSet {
            isTopMenuExists = menuAndalan.count > 0
        }
    }
    
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var stackView = UIStackView()
    
    let welcomingHeader = WelcomingHeader()
    
    let cardKasUsaha = CardKasUsaha()
    let carouselStatistik = Carousel()
    
    let sectionPrediksiPenjualan = CardEmptyStateDashboard()
    let sectionMenuAndalan = CardEmptyStateDashboard()
    
    let sectionPrediksiPenjualanFilled = CardPrediksiPenjualan()
    let sectionMenuAndalanFilled = CardMenuAndalan()
    
    
    init(statusPrediction: Bool = false, statusKas: Bool = false) {
         
        super.init(frame: .zero)
        
        ({
            self.isPredictionExists = statusPrediction
            self.kasIsSet = statusKas
            self.menuAndalan = []
        })()
        
        addSubviews()
        setUpData()
        setUpViews()
        setUpConstraints()
    }
    
    func setInitValue(statusPrediction: Bool, isTopMenuExists: Bool) {
        self.isPredictionExists = statusPrediction
        self.isTopMenuExists = isTopMenuExists
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        let icon = UIImage(systemName: "person.circle.fill")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        welcomingHeader.profileButton.setBackgroundImage(icon, for: .normal)
        welcomingHeader.profileButton.frame = iconSize
    }
    
    private func addSubviews() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        switch isPredictionExists {
        case true:
            // titleLabel, profileIcon,
            [welcomingHeader, cardKasUsaha, carouselStatistik, sectionPrediksiPenjualanFilled, sectionMenuAndalan, sectionMenuAndalanFilled]
                .forEach {
                    stackView.addArrangedSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        case false:
            // titleLabel, profileIcon
            [welcomingHeader, cardKasUsaha, carouselStatistik, sectionPrediksiPenjualan, sectionMenuAndalan, sectionMenuAndalanFilled]
                .forEach {
                    stackView.addArrangedSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        }
    }
    
    private func setUpData() {
        // data for section - prediction
        sectionPrediksiPenjualan.sectionLabel.text = "Prediksi Penjualan"
        sectionPrediksiPenjualan.sectionDescription1.text = "Data Kamu Masih Belum Mencukupi"
        sectionPrediksiPenjualan.sectionDescription2.text = "Hasil prediksi penjualan akan muncul disini setelah data tersedia minimal 1 minggu terakhir"
        sectionPrediksiPenjualan.sectionImage.image = UIImage(named: "Prediksi Empty.png")
        
        // data for section - menu andalan
        sectionMenuAndalan.sectionLabel.text = "Menu Andalan"
        sectionMenuAndalan.sectionDescription1.text = "Menu Andalan Belum Tersedia"
        sectionMenuAndalan.sectionDescription2.text = "Hasil menu andalan akan muncul disini setelah data tersedia minimal 1 minggu terakhir"
        sectionMenuAndalan.sectionImage.image = UIImage(named: "Menu Andalan Empty.png")
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
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
        
        //
//        titleLabel.text = "HALOOO"
//        titleLabel.font = Font.headingSix.getUIFont
//        titleLabel.textColor = UIColor.Neutral._90
//
//        titleLabel.backgroundColor = .green
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Stack View
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
    
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            cardKasUsaha.topAnchor.constraint(equalTo: welcomingHeader.bottomAnchor, constant: 10),
            cardKasUsaha.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            cardKasUsaha.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            carouselStatistik.topAnchor.constraint(equalTo: cardKasUsaha.bottomAnchor, constant: 10),
            carouselStatistik.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            carouselStatistik.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            carouselStatistik.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        switch isPredictionExists {
        case true:
            NSLayoutConstraint.activate([
                sectionPrediksiPenjualanFilled.topAnchor.constraint(equalTo: carouselStatistik.bottomAnchor, constant: 10),
                sectionPrediksiPenjualanFilled.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                sectionPrediksiPenjualanFilled.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            ])
        case false:
            NSLayoutConstraint.activate([
                sectionPrediksiPenjualan.topAnchor.constraint(equalTo: carouselStatistik.bottomAnchor, constant: 10),
                sectionPrediksiPenjualan.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
                sectionPrediksiPenjualan.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            ])
        }
        
        NSLayoutConstraint.activate([
//            Menu Andalan not Exists
            sectionMenuAndalan.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            sectionMenuAndalan.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
//            Menu Andalan Exists
            sectionMenuAndalanFilled.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            sectionMenuAndalanFilled.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20)
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
