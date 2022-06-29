//
//  ProfileView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 21/06/22.
//

import UIKit

class ProfileView: UIView {
    
    lazy var containerUserCard = UIView()
    lazy var userCard = UserCard()
    lazy var changePINButton = UIButton(type: .system)
    lazy var logoutButton = UIButton(type: .system)
    
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
        
        containerUserCard.addSubview(userCard)
        
        [containerUserCard, changePINButton, logoutButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        self.backgroundColor = .white
        
        // User Card
        userCard.translatesAutoresizingMaskIntoConstraints = false
        userCard.layer.cornerRadius = 12
        userCard.layer.masksToBounds = true
        
        // Container Card Card
        containerUserCard.translatesAutoresizingMaskIntoConstraints = false
        containerUserCard.layer.masksToBounds = false
        containerUserCard.layer.shadowColor = UIColor.gray.cgColor
        containerUserCard.layer.shadowOpacity = 0.2
        containerUserCard.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        containerUserCard.layer.shadowRadius = 10
        
        // Heading Label
        changePINButton.setImage(UIImage(systemName: "lock.fill"), for: .normal)
        changePINButton.setTitle(" Ganti PIN", for: .normal)
        changePINButton.backgroundColor = UIColor.Primary._30_15
        changePINButton.tintColor = UIColor.Primary._30
        changePINButton.titleLabel?.font = Font.textRegularSemiBold.getUIFont
        changePINButton.layer.cornerRadius = 10
        
        // PIN Text Field
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.tintColor = UIColor.Error._90
        logoutButton.layer.borderColor = UIColor.Error._90.cgColor
        logoutButton.layer.borderWidth = 1
        logoutButton.titleLabel?.font = Font.textRegularSemiBold.getUIFont
        logoutButton.layer.cornerRadius = 10
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
//             User Card
            userCard.topAnchor.constraint(equalTo: containerUserCard.topAnchor),
            userCard.bottomAnchor.constraint(equalTo: containerUserCard.bottomAnchor),
            userCard.leftAnchor.constraint(equalTo: containerUserCard.leftAnchor),
            userCard.rightAnchor.constraint(equalTo: containerUserCard.rightAnchor),
            
//             Container User Card
            containerUserCard.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            containerUserCard.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            containerUserCard.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
//            Change PIN Button
            changePINButton.topAnchor.constraint(equalTo: userCard.bottomAnchor, constant: 25),
            changePINButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            changePINButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            changePINButton.heightAnchor.constraint(equalToConstant: 48),

//            Logout Button
            logoutButton.topAnchor.constraint(equalTo: changePINButton.bottomAnchor, constant: 10),
            logoutButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            logoutButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            ProfileView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif

