//
//  UserCard.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import Foundation
import UIKit

class UserCard: UIView {
    
    lazy var profileIcon = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var usernameLabel = RegularLabel()
    lazy var buttonEdit = UIButton(type: .system)
    
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
        [profileIcon, nameLabel, usernameLabel, buttonEdit]
            .forEach {
                addSubview($0)
                $0
                    .translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        self.backgroundColor = .white
        
        profileIcon.image = UIImage(systemName: "person.circle.fill")
        profileIcon.tintColor = UIColor.Neutral._50
        profileIcon.contentMode = .scaleAspectFit
        
        nameLabel.font = Font.textRegularSemiBold.getUIFont
        nameLabel.textColor = UIColor.Neutral._90
        nameLabel.text = "Nama Usaha"
        nameLabel.numberOfLines = 0
        
        usernameLabel.text = "@username"
        usernameLabel.font = Font.text.getUIFont
        usernameLabel.textColor = UIColor.Neutral._70
        usernameLabel.numberOfLines = 0
        
        buttonEdit.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        buttonEdit.tintColor = UIColor.Neutral._90
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            profileIcon.widthAnchor.constraint(equalToConstant: 60),
            profileIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            profileIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            profileIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            buttonEdit.widthAnchor.constraint(equalToConstant: 25),
            buttonEdit.heightAnchor.constraint(equalToConstant: 25),
            buttonEdit.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            buttonEdit.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: profileIcon.rightAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: buttonEdit.leftAnchor, constant: -10),
            
            usernameLabel.leftAnchor.constraint(equalTo: profileIcon.rightAnchor, constant: 10),
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            usernameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            usernameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 20),
            
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

