//
//  RiwayatTransaksiTableViewCell.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 24/06/22.
//

import UIKit

class RiwayatTransaksiTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: false)
//
//        // Configure the view for the selected state
//    }
    
    static let identifier = "RiwayatTransaksiCell"
    
    lazy var transaksiId = UILabel()
    lazy var transaksiDate = UILabel()
    lazy var transaksiCategory = UILabel()
    lazy var transaksiAmount = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        [transaksiId, transaksiDate, transaksiCategory, transaksiAmount]
            .forEach {
                contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        contentView.backgroundColor = .white
        transaksiId.text = "Pemasukan #0001"
        transaksiDate.text = "08 Juni 2022"
        transaksiCategory.text = "Offline"
        transaksiAmount.text = "+ Rp 100.000"
        
        transaksiAmount.font = Font.textRegularSemiBold.getUIFont
        transaksiAmount.textColor = UIColor.Primary._30
        
        transaksiCategory.font = UIFont(name: "Inter-Regular", size: 12)
        transaksiCategory.textColor = UIColor.Success._90
        transaksiCategory.backgroundColor = UIColor(red: 133/255, green: 218/255, blue: 195/255, alpha: 0.3)
        transaksiCategory.textAlignment = .center
        transaksiCategory.layer.masksToBounds = true
        transaksiCategory.layer.cornerRadius = 10
        
        transaksiDate.font = UIFont(name: "Inter-Regular", size: 10)
        transaksiDate.textColor = UIColor.Neutral._70
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
            
            transaksiId.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            transaksiCategory.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            
            transaksiId.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            transaksiDate.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            
            transaksiCategory.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            transaksiAmount.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            
            transaksiDate.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            transaksiAmount.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            
            transaksiCategory.widthAnchor.constraint(equalToConstant: 80),
            transaksiCategory.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct RiwayatTransaksiTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            RiwayatTransaksiTableViewCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif