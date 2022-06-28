//
//  UserCard.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import Foundation
import UIKit

class UserCard: UIView {
    
    //lazy var profileIcon = UIImageView()
    lazy var namaUsahaLabel = UILabel()
    lazy var userNameLabel = RegularLabel()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        [namaUsahaLabel, userNameLabel]
            .forEach {
                addSubview($0)
                $0
                    .translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        //profileIcon.image = UIImage(named: "Profile Icon.png")
        
        namaUsahaLabel.font = UIFont(name: "Inter-Bold", size: 22)
        namaUsahaLabel.text = "Warung Bude"
        userNameLabel.text = "@budesiti"
        
    }
    
    func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 90),
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 50),
            
            namaUsahaLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            namaUsahaLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            userNameLabel.topAnchor.constraint(equalTo: namaUsahaLabel.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct UserCard_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            UserCard().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif



/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */
