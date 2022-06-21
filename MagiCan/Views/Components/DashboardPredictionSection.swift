//
//  CardTypeTwo.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import Foundation
import UIKit

class DashboardPredictionSection: UIView {

    lazy var sectionLabel = UILabel()
    lazy var dividerLine = UIView()
    lazy var sectionDescription1 = UILabel()
    lazy var sectionDescription2 = UILabel()
    lazy var sectionImage = UIImageView()
    
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
        [sectionLabel, dividerLine, sectionImage, sectionDescription1, sectionDescription2]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
//        sectionLabel.text = "Prediksi Penjualan"
//        sectionDescription1.text = "Data Kamu Masih Belum Mencukupi"
//        sectionDescription2.text = "Hasil prediksi penjualan akan muncul disini setelah data tersedia minimal 1 bulan terakhir"
//        sectionImage.image = UIImage(named: "Prediksi Empty.png")
        
        sectionLabel.font = Font.subtitleSemiBold.getUIFont
        sectionDescription1.font = Font.textSemiBold.getUIFont
        sectionDescription2.font = Font.small.getUIFont
        
        sectionDescription1.numberOfLines = 0
        sectionDescription2.numberOfLines = 0
        sectionDescription2.textAlignment = .center
        
        sectionDescription2.textColor = UIColor.Neutral._70
        dividerLine.backgroundColor = UIColor.Neutral._30
    }
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 220),
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
            
            sectionLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            sectionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 10),
            dividerLine.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            dividerLine.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            
            sectionImage.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 50),
            sectionImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            sectionDescription1.topAnchor.constraint(equalTo: sectionImage.bottomAnchor, constant: 20),
            sectionDescription1.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            sectionDescription2.topAnchor.constraint(equalTo: sectionDescription1.bottomAnchor, constant: 10),
            sectionDescription2.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            sectionDescription2.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            sectionDescription2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30)
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct DashboardPredictionSection_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            DashboardPredictionSection().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
