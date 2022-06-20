//
//  RegisterView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import Foundation
import UIKit

class RegisterView: UIView {
    
    let welcomeLabel = HeadingFiveLabel()
    let descriptionLabel = RegularLabel()
    let nameField = UITextField()
    let usernameField = UITextField()
    let warningLabel = WarningLabel()
    let continueButton = PrimaryButton()
    let stackHView = UIStackView()
    let loginLabel = UILabel()
    let loginButton = UIButton(type: .system)
    
    var isUsernameValid: Bool = false {
        didSet {
            if isUsernameValid {
                continueButton.isEnabled = true
                usernameField.updateStateSuccess()
                warningLabel.text = ""
            } else if usernameField.text != "" {
                continueButton.isEnabled = false
                usernameField.updateStateError()
                warningLabel.text = "Username tidak tersedia. Silakan mencoba username lain"
            } else if usernameField.text == "" {
                continueButton.isEnabled = false
                usernameField.updateStateDefault()
                warningLabel.text = ""
            }
        }
    }
    
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
        stackHView.addArrangedSubview(loginLabel)
        stackHView.addArrangedSubview(loginButton)
        
        [welcomeLabel, descriptionLabel, nameField, usernameField, warningLabel, continueButton, stackHView]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        // Welcome Label
        welcomeLabel.text = "Selamat Datang, Bos!"
        
        // Description Label
        descriptionLabel.text = "Isi nama usaha dan username kamu dulu ya biar kita semakin kenal"
        
        // Name Field
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Nama Usaha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        nameField.updateStateDefault()
        
        // Username Field
        usernameField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        usernameField.updateStateDefault()
        
        // Continue Button
        continueButton.isEnabled = false
        continueButton.setTitle("Selanjutnya", for: .normal)
        
        // Stack H View
        stackHView.axis = .horizontal
        stackHView.alignment = .center
        stackHView.spacing = 5
        
        // Login Label
        loginLabel.text = "Sudah punya akun?"
        loginLabel.font = UIFontMetrics.default.scaledFont(for: Font.text.getUIFont)
        loginLabel.numberOfLines = 0
        loginLabel.textColor = UIColor.Neutral._90
        
        // Login Button
        loginButton.setTitle("Masuk", for: .normal)
        loginButton.tintColor = UIColor.Primary._30
        loginButton.titleLabel?.font = Font.textSemiBold.getUIFont
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Welcome Label
            welcomeLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            welcomeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Name Field
            nameField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            nameField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 44),
            
            // Username Field
            usernameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            usernameField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            usernameField.heightAnchor.constraint(equalToConstant: 44),
            
            warningLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 5),
            warningLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Continue Button
            continueButton.bottomAnchor.constraint(equalTo: stackHView.topAnchor),
            continueButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            
            // Stack H View
            stackHView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 12),
            stackHView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            stackHView.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct RegisterView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            RegisterView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
