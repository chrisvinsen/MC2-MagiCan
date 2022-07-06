//
//  WelcomingHeader.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 05/07/22.
//

import UIKit

class WelcomingHeader: UIView {

    let titleLabel = UILabel()
    let titleName = UILabel()
    var name: String = "Tamu" {
        didSet {
            print("ini set nama jadi", name)
            var tempName = "Tamu"
            if name != "" {
                tempName = name;
            }
//            self.titleLabel.font = Font.headingSix.getUIFont
//            self.titleLabel.textColor = UIColor.Neutral._90
//            self.titleLabel.text = "Selamat Datang, \(tempName)"
            
            self.titleName.text = name
        }
    }
    
    let profileButton = UIButton()
    
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
        [titleLabel, titleName, profileButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        titleLabel.text = "Selamat Datang,"
        titleLabel.font = Font.textSemiBold.getUIFont
        titleLabel.textColor = UIColor.Neutral._70
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .default)
        let icon = UIImage(systemName: "person.circle.fill", withConfiguration: iconConfig)
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
        profileButton.setBackgroundImage(icon, for: .normal)
        profileButton.frame = iconSize
        profileButton.tintColor = UIColor.Primary._30
        
        titleName.text = "Tamu"
        titleName.font = Font.headingSix.getUIFont
        titleName.textColor = UIColor.Neutral._90
    }

    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 70),
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
//            titleLabel.rightAnchor.constraint(equalTo: profileButton.leftAnchor, constant: -20),
            
            titleName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleName.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
//            titleName.rightAnchor.constraint(equalTo: profileButton.leftAnchor, constant: -20),
            
//            profileButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            profileButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            profileButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct WelcomingHeader_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            WelcomingHeader().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
