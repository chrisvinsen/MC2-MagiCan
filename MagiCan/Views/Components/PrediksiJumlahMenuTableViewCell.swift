//
//  PrediksiJumlahMenuTableViewCell.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 24/06/22.
//

import UIKit

class PrediksiJumlahMenuTableViewCell: UITableViewCell {

    static let identifier = "PrediksiJumlahMenuCell"
    
    lazy var menuName = UILabel()
    lazy var menuPrice = UILabel()
    lazy var menuQty = UILabel()
    lazy var timesLabel = UILabel()
    lazy var menuImg = UIImageView()
    
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
        [menuName, menuPrice, menuQty, timesLabel, menuImg]
            .forEach {
                contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        contentView.backgroundColor = .white
        menuName.text = "Bakso"
        menuPrice.text = "@ Rp 35.000"
        menuQty.text = "250x"
        timesLabel.text = "terjual"
        menuImg.image = UIImage(named: "SampleBakso.png")
        
        menuImg.layer.cornerRadius = 10
        menuImg.clipsToBounds = true
        menuImg.contentMode = UIView.ContentMode.scaleAspectFill
        
        menuName.font = Font.textRegularSemiBold.getUIFont
        menuPrice.font = UIFont(name: "Inter-Regular", size: 14)
        timesLabel.font = Font.small.getUIFont
        menuQty.font = UIFont(name: "Inter-SemiBold", size: 14)
        
        menuPrice.textColor = UIColor.Neutral._70
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
            
            menuImg.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            menuImg.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            menuImg.widthAnchor.constraint(equalToConstant: 60),
            menuImg.heightAnchor.constraint(equalToConstant: 60),
            
            menuName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            menuName.leftAnchor.constraint(equalTo: menuImg.rightAnchor, constant: 10),
            
            menuPrice.leftAnchor.constraint(equalTo: menuImg.rightAnchor, constant: 10),
            menuPrice.topAnchor.constraint(equalTo: menuName.bottomAnchor, constant: 10),
            
            timesLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            timesLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            menuQty.rightAnchor.constraint(equalTo: timesLabel.leftAnchor, constant: -5),
            menuQty.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PrediksiJumlahMenuTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            PrediksiJumlahMenuTableViewCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
