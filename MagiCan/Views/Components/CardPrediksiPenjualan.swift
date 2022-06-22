//
//  CardPrediksiPejualan.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 22/06/22.
//

import UIKit

class CardPrediksiPenjualan: UIView {
    
    lazy var sectionLabel = UILabel()
    lazy var dividerLine = UIView()
    lazy var timeTag = UILabel()
    lazy var predictedAmount = UILabel()
    lazy var menu1 = CardPrediksiPenjualanItem()
    lazy var menu2 = CardPrediksiPenjualanItem()
    lazy var menu3 = CardPrediksiPenjualanItem()

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
        [sectionLabel, dividerLine, timeTag, predictedAmount, menu1, menu2, menu3]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        sectionLabel.text = "Prediksi Penjualan"
        predictedAmount.text = "Rp 8.000.000"
        timeTag.text = "Minggu Depan"
        
        sectionLabel.font = Font.subtitleSemiBold.getUIFont
        dividerLine.backgroundColor = UIColor.Neutral._30
        predictedAmount.font = UIFont(name: "Inter-Bold", size: 18)
        
        timeTag.font = UIFont(name: "Inter-Medium", size: 12)
        timeTag.textColor = UIColor.Secondary._30
        timeTag.backgroundColor = UIColor(red: 250/255, green: 243/255, blue: 201/255, alpha: 0.5)
        timeTag.textAlignment = .center
        timeTag.layer.masksToBounds = true
        timeTag.layer.cornerRadius = 10
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
            
            sectionLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            sectionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            
            timeTag.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            timeTag.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            timeTag.widthAnchor.constraint(equalToConstant: 100),
            timeTag.heightAnchor.constraint(equalToConstant: 20),
            
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 10),
            dividerLine.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            dividerLine.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            
            predictedAmount.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            predictedAmount.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 10),
            
            menu2.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            menu2.topAnchor.constraint(equalTo: predictedAmount.bottomAnchor, constant: 20),
            menu2.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15),
            
            menu1.topAnchor.constraint(equalTo: predictedAmount.bottomAnchor, constant: 20),
            menu1.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15),
            
            menu3.topAnchor.constraint(equalTo: predictedAmount.bottomAnchor, constant: 20),
            menu3.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15)
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CardPrediksiPenjualan_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            CardPrediksiPenjualan().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
