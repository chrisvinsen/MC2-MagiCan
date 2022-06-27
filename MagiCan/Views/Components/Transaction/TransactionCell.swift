//
//  TransactionCell.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit


class TransactionCell: UITableViewCell {
    
    lazy var titleLabel = UILabel()
    lazy var dateLabel = UILabel()
    lazy var typeLabel = UILabel()
    lazy var amountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        [titleLabel, dateLabel, typeLabel, amountLabel]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        titleLabel.text = "Pemasukan #0001"
        titleLabel.font = Font.textRegular.getUIFont
        titleLabel.textColor = UIColor.Neutral._90
        
        dateLabel.text = "08 Juni 2022"
        dateLabel.font = Font.small.getUIFont
        dateLabel.textColor = UIColor.Neutral._70
        
        amountLabel.text = "+ 100.000"
        amountLabel.font = Font.textRegularSemiBold.getUIFont
        amountLabel.textColor = UIColor.Primary._30
        
        typeLabel.text = "Online"
        typeLabel.font = Font.small.getUIFont
        typeLabel.textColor = UIColor.Success._90
//        typeLabel.backgroundColor = .red
//        typeLabel.textColor = UIColor.Secondary._30
        typeLabel.backgroundColor = UIColor(red: 250/255, green: 243/255, blue: 201/255, alpha: 0.5)
        typeLabel.textAlignment = .center
        typeLabel.layer.masksToBounds = true
        typeLabel.layer.cornerRadius = 10
        
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            typeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            typeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            amountLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 15),
            amountLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
        ])
        
//        let imgBottomConstraint = menuImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
//        imgBottomConstraint.priority = .defaultLow
//        imgBottomConstraint.isActive = true
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct TransactionCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            TransactionCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
