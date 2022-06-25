//
//  MenuCell.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 24/06/22.
//

import UIKit

class MenuCell: UITableViewCell {
    
    lazy var menuImage = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        [menuImage, nameLabel, descriptionLabel]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        // Image View
        menuImage.image = UIImage(named: "SampleBakso.png") // Default
        menuImage.contentMode = .scaleAspectFill
        menuImage.layer.cornerRadius = 10
        menuImage.clipsToBounds = true
        
        // Name Label
//        nameLabel.text = "Name of Menu Name of Menu Name of Menu Name of Menu"
//        nameLabel.text = "Menu Name"
        nameLabel.numberOfLines = 1
        nameLabel.textColor = UIColor.Neutral._90
        nameLabel.font = UIFontMetrics.default.scaledFont(for: Font.textRegularSemiBold.getUIFont)
        nameLabel.adjustsFontForContentSizeCategory = true
        
        // Description Label
//        descriptionLabel.text = "Long Description Written Here Long Description Written Here Long Description Written Here Long Description Written Here"
//        descriptionLabel.text = "Long Description Written Here"
        descriptionLabel.numberOfLines = 1
        descriptionLabel.textColor = UIColor.Neutral._70
        descriptionLabel.font = UIFontMetrics.default.scaledFont(for: Font.text.getUIFont)
        descriptionLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
//            Image View
            menuImage.widthAnchor.constraint(equalToConstant: 60),
            menuImage.heightAnchor.constraint(equalToConstant: 60),
            menuImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            menuImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
//            Name Label
            nameLabel.leadingAnchor.constraint(equalTo: menuImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
//            Description Label
            descriptionLabel.leadingAnchor.constraint(equalTo: menuImage.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
        ])
        
        let imgBottomConstraint = menuImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        imgBottomConstraint.priority = .defaultLow
        imgBottomConstraint.isActive = true
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MenuCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            MenuCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
