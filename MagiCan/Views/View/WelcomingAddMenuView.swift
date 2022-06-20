//
//  WelcomingAddMenuView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import Foundation
import UIKit

class WelcomingAddMenuView: UIView {
    
    let titleLabel = HeadingFiveLabel()
    let subTitleLabel = RegularLabel()
    let addButton = PrimaryButton()
    let skipButton = UIButton(type: .system)
    
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
        
        [titleLabel, subTitleLabel, addButton, skipButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        // Title Label
        titleLabel.text = "Isi Menu Dulu Yuk!"
        
        // Sub Title Label
        subTitleLabel.text = "Tambah daftar menu usaha kamu untuk mencatat penjualan jadi lebih mudah"
        
        // Add Button
        addButton.setTitle("Tambah Menu", for: .normal)
        
        // Skip Button
        skipButton.setTitle("Nanti Saja", for: .normal)
        skipButton.backgroundColor = UIColor.Primary._30_15
        skipButton.tintColor = UIColor.Primary._30
        skipButton.titleLabel?.font = Font.textRegularSemiBold.getUIFont
        skipButton.layer.cornerRadius = 10
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Sub Title Label
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Add Button
            addButton.heightAnchor.constraint(equalToConstant: 48),
            addButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40),
            addButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Skip Button
            skipButton.heightAnchor.constraint(equalToConstant: 48),
            skipButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15),
            skipButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct WelcomingAddMenuView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            WelcomingAddMenuView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
