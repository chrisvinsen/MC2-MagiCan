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
        
        menuName.font = Font.textSemiBold.getUIFont
        menuQty.font = Font.small.getUIFont

        menuName.textColor = UIColor.Primary._90
        menuQty.textColor = UIColor.Neutral._70
        
        menuName.numberOfLines = 1
        menuQty.numberOfLines = 1
        
        menuImage.layer.cornerRadius = 10
        menuImage.clipsToBounds = true
        menuImage.contentMode = .scaleAspectFill
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            menuImage.topAnchor.constraint(equalTo: safeArea.topAnchor),
            menuImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            menuImage.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            menuImage.heightAnchor.constraint(equalTo: menuImage.widthAnchor),
            
            menuName.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            menuQty.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            
            menuName.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            menuQty.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            
            menuName.topAnchor.constraint(equalTo: menuImage.bottomAnchor, constant: 10),
            menuQty.topAnchor.constraint(equalTo: menuName.bottomAnchor, constant: 5),
            
            menuQty.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
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
