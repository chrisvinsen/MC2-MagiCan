//
//  CardTransactionView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit


class CardTransactionView: UIView {
    
    lazy var pemasukanLabel = UILabel()
    lazy var pengeluaranLabel = UILabel()
    lazy var jumlahPemasukanLabel = UILabel()
    lazy var jumlahPengeluaranLabel = UILabel()
    
    lazy var keuntunganBox = UIView()
    lazy var keuntunganLabel = UILabel()
    
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    private func addSubviews() {
        
        keuntunganBox.addSubview(keuntunganLabel)
        
        [pemasukanLabel, pengeluaranLabel, jumlahPemasukanLabel, jumlahPengeluaranLabel, keuntunganBox]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        self.backgroundColor = .white
        
        pemasukanLabel.text = "Pemasukan"
        pemasukanLabel.font = Font.textRegularSemiBold.getUIFont
        pemasukanLabel.textColor = UIColor.Neutral._90
        
        pengeluaranLabel.text = "Pengeluaran"
        pengeluaranLabel.font = Font.textRegularSemiBold.getUIFont
        pengeluaranLabel.textColor = UIColor.Neutral._90
        
        jumlahPemasukanLabel.text = "Rp 500.000"
        jumlahPemasukanLabel.font = Font.textRegularSemiBold.getUIFont
        jumlahPemasukanLabel.textColor = UIColor.Primary._30
        
        jumlahPengeluaranLabel.text = "Rp 500.000"
        jumlahPengeluaranLabel.font = Font.textRegularSemiBold.getUIFont
        jumlahPengeluaranLabel.textColor = UIColor.Error._30
        
        keuntunganBox.backgroundColor = UIColor.Primary._50
        
        keuntunganLabel.translatesAutoresizingMaskIntoConstraints = false
        keuntunganLabel.text = "Rp 500.000"
        keuntunganLabel.font = Font.textBold.getUIFont
        keuntunganLabel.textColor = .white
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            pemasukanLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            pemasukanLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            
            pengeluaranLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            pengeluaranLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            jumlahPemasukanLabel.topAnchor.constraint(equalTo: pemasukanLabel.bottomAnchor, constant: 6),
            jumlahPemasukanLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            
            jumlahPengeluaranLabel.topAnchor.constraint(equalTo: pengeluaranLabel.bottomAnchor, constant: 6),
            jumlahPengeluaranLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            keuntunganBox.topAnchor.constraint(equalTo: jumlahPemasukanLabel.bottomAnchor, constant: 50),
            keuntunganBox.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            keuntunganBox.leftAnchor.constraint(equalTo: self.leftAnchor),
            keuntunganBox.rightAnchor.constraint(equalTo: self.rightAnchor),
            keuntunganBox.heightAnchor.constraint(equalToConstant: 35),
            
            keuntunganLabel.centerXAnchor.constraint(equalTo: keuntunganBox.centerXAnchor),
            keuntunganLabel.centerYAnchor.constraint(equalTo: keuntunganBox.centerYAnchor),
        ])
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CardTransactionView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            CardTransactionView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif


