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
    let sectionPrediksiPenjualan = DashboardPredictionSection()
//    let sectionMenuAndalan = DashboardMenuSection()

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
        [titleLabel, cardKasUsaha]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        titleLabel.text = "Selamat datang, XXX"
        
        cardKasUsaha.layer.masksToBounds = false
        cardKasUsaha.layer.shadowColor = UIColor.black.cgColor
        cardKasUsaha.layer.shadowOpacity = 0.2
        cardKasUsaha.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cardKasUsaha.layer.shadowRadius = 10
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
