//
//  CardMenuAndalanItem.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 22/06/22.
//

import UIKit

class CardMenuAndalanItem: UIView {
    
    lazy var menuImage = UIImageView()
    lazy var menuName = UILabel()
    lazy var menuQty = UILabel()
    
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
        [menuImage, menuName, menuQty]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.layer.cornerRadius = 10
        
        menuName.text = "Bakso"
        menuQty.text = "2000x"
        menuImage.image = UIImage(named: "SampleBakso.png")
        
        menuName.font = Font.textSemiBold.getUIFont
        menuQty.font = Font.small.getUIFont

        menuName.textColor = UIColor.Primary._90
        menuQty.textColor = UIColor.Neutral._70
        
        menuImage.layer.cornerRadius = 10
        menuImage.clipsToBounds = true
        menuImage.contentMode = UIView.ContentMode.scaleAspectFill
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 110),
            self.heightAnchor.constraint(equalToConstant: 180),
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            menuImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            menuImage.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            menuImage.widthAnchor.constraint(equalToConstant: 100),
            menuImage.heightAnchor.constraint(equalToConstant: 125),
            
            menuName.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            menuQty.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            
            menuName.topAnchor.constraint(equalTo: menuImage.bottomAnchor, constant: 10),
            menuQty.topAnchor.constraint(equalTo: menuName.bottomAnchor, constant: 5),
            
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CardMenuAndalanItem_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            CardMenuAndalanItem().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
