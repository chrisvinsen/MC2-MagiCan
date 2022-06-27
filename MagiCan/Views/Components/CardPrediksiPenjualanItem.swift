//
//  CardPrediksiPenjualan.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 22/06/22.
//

import UIKit

class CardPrediksiPenjualanItem: UIView {

    lazy var menuLabel = UILabel()
    lazy var menuQty = UILabel()
    lazy var terjualLabel = UILabel()
    
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
        [menuLabel, menuQty, terjualLabel]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.5)
        
        menuLabel.text = "Bakso"
        menuQty.text = "120x"
        terjualLabel.text = "Terjual"
        
        menuLabel.font = Font.small.getUIFont
        menuQty.font = UIFont(name: "Inter-Bold", size: 16)
        terjualLabel.font = UIFont(name: "Inter-Regular", size: 10)
        
        menuLabel.textColor = UIColor.Neutral._90
        menuQty.textColor = UIColor.Primary._90
        terjualLabel.textColor = UIColor.Neutral._70
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 110),
            self.heightAnchor.constraint(equalToConstant: 100),
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            menuLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            menuQty.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            terjualLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            menuLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            menuQty.topAnchor.constraint(equalTo: menuLabel.bottomAnchor, constant: 20),
            terjualLabel.topAnchor.constraint(equalTo: menuQty.bottomAnchor, constant: 10)
        ])
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CardPrediksiPenjualanItem_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            CardPrediksiPenjualanItem().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
