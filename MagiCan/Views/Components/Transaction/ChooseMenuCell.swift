//
//  ChooseMenuCell.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit


class ChooseMenuCell: UITableViewCell {
    
    lazy var titleLabel = UILabel()
    lazy var iconImage = UIImageView()
    lazy var divider = UIView()
    
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
        
        [titleLabel, iconImage, divider]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        titleLabel.text = "Pilih Menu"
        titleLabel.font = Font.textBold.getUIFont
        titleLabel.textColor = UIColor.Neutral._90
        
        let image = UIImage(systemName: "plus.circle.fill")
        iconImage.image = image
        iconImage.contentMode = .scaleAspectFill
        
        divider.backgroundColor = UIColor.Neutral._50
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            iconImage.heightAnchor.constraint(equalToConstant: 25),
            iconImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            divider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            divider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ChooseMenuCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            ChooseMenuCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
