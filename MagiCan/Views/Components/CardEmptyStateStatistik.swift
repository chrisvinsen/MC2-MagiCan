//
//  CardEmptyStateStatistik.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 21/06/22.
//

import UIKit

class CardEmptyStateStatistik: UIView {

    lazy var sectionDescription1 = UILabel()
    lazy var sectionDescription2 = UILabel()
    lazy var button = SecondaryButton()
    
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
        [sectionDescription1, sectionDescription2, button]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        sectionDescription1.text = "Belum  Ada Transaksi Pada Periode Ini"
        sectionDescription2.text = "Kamu bisa melihat grafik setelah ada transaksi yang tercatat pada periode ini minimal 1 minggu terakhir"
        button.setTitle("Tambah Transaksi", for: .normal)
        
        sectionDescription1.font = Font.textSemiBold.getUIFont
        sectionDescription2.font = Font.small.getUIFont
        
        sectionDescription2.textColor = UIColor.Neutral._70
        
        sectionDescription1.numberOfLines = 0
        sectionDescription2.numberOfLines = 0
        sectionDescription2.textAlignment = .center
    }
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
            
            sectionDescription1.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 48),
            sectionDescription1.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            sectionDescription2.topAnchor.constraint(equalTo: sectionDescription1.bottomAnchor, constant: 10),
            sectionDescription2.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            sectionDescription2.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 40),
            sectionDescription2.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -40),
            
            button.topAnchor.constraint(equalTo: sectionDescription2.bottomAnchor, constant: 25),
            button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            button.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -48)
        ])
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CardEmptyStateStatistik_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            CardEmptyStateStatistik().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
