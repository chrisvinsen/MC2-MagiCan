//
//  CarouselCell.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 24/06/22.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    static let identifier = "CarouselCell"
    
    lazy var cardLabel = UILabel()
    lazy var cardAmount = UILabel()
    lazy var cardTime = UILabel()
    lazy var cardIcon = UIImageView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        [cardLabel, cardAmount, cardTime, cardIcon]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 10
        
        cardLabel.text = "Total Keuntungan"
        cardAmount.text = "Rp 0"
        cardTime.text = "Minggu Ini"
        cardIcon.image = UIImage(named: "CarouselIcon.png")
        
        cardLabel.textColor = .white
        cardAmount.textColor = .white
        cardTime.textColor = .white
        
        cardLabel.font = UIFont(name: "Inter-SemiBold", size: 12)
        cardAmount.font = Font.headingSix.getUIFont
        cardTime.font = Font.small.getUIFont
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
//            self.widthAnchor.constraint(equalToConstant: 220),
//            self.heightAnchor.constraint(equalToConstant: 112),
//            
            cardLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            cardLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            
            cardAmount.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 10),
            cardAmount.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            
            cardTime.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            cardTime.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            
            cardIcon.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            cardIcon.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        ])
    }
    
}

extension CarouselCell {
    public func configure(cardlabel: String, cardamount: String, cardtime: String, cardicon: String) {
        cardLabel.text = cardlabel
        cardAmount.text = cardamount
        cardTime.text = cardtime
        cardIcon.image = UIImage(named: cardicon)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CarouselCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            CarouselCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
