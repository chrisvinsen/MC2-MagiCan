//
//  LoginView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    lazy var welcomeLabel = HeadingFiveLabel()
    lazy var descriptionLabel = RegularLabel()
    lazy var usernameField = UITextField()
    lazy var warningLabel = WarningLabel()
    lazy var loginButton = PrimaryButton()
    lazy var stackHView = UIStackView()
    lazy var registerLabel = UILabel()
    lazy var registerButton = UIButton(type: .system)
    lazy var bottomLine = CALayer()
    
    var isUsernameExists: Bool = false
    
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
        stackHView.addArrangedSubview(registerLabel)
        stackHView.addArrangedSubview(registerButton)
        
        [welcomeLabel, descriptionLabel, usernameField, warningLabel, loginButton, stackHView]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        // Welcome Label
        welcomeLabel.text = "Halo, Bos!"
        
        // Description Label
        descriptionLabel.text = "Isi username dulu ya buat masuk"
        
        // Username Field
        usernameField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        usernameField.updateStateDefault()
        
        // Login Button
        loginButton.setTitle("Masuk", for: .normal)
        
        // Stack H View
        stackHView.axis = .horizontal
        stackHView.alignment = .center
        stackHView.spacing = 5
        
        // Login Label
        registerLabel.text = "Belum punya akun?"
        registerLabel.font = UIFontMetrics.default.scaledFont(for: Font.text.getUIFont)
        registerLabel.numberOfLines = 0
        registerLabel.textColor = UIColor.Neutral._90
        
        // Login Button
        registerButton.setTitle("Daftar", for: .normal)
        registerButton.tintColor = UIColor.Primary._30
        registerButton.titleLabel?.font = Font.textSemiBold.getUIFont
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
            
            // Username Field
            usernameField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            usernameField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            usernameField.heightAnchor.constraint(equalToConstant: 44),
            
            // Warning Label
            warningLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 10),
            warningLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Login Button
            loginButton.bottomAnchor.constraint(equalTo: stackHView.topAnchor),
            loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
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
struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            LoginView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
