//
//  TextFieldWithCardCell.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit

class TextFieldWithCardCell: UITableViewCell {

    lazy var textField = TextFieldWithCard(title: "Total Pemasukan", prefixValue: "Rp", valuePlaceholder: "", isEnabled: false)
    lazy var iconImage = UIImageView()
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
        
        [textField, iconImage, descriptionLabel]
            .forEach {
                contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        let image = UIImage(systemName: "info.circle.fill")
        iconImage.image = image
        iconImage.contentMode = .scaleAspectFill
        iconImage.tintColor = UIColor.Neutral._70
        
        descriptionLabel.text = "Total pemasukan otomatis keluar setelah kamu memilih menu"
        descriptionLabel.font = Font.text.getUIFont
        descriptionLabel.textColor = UIColor.Neutral._70
        descriptionLabel.numberOfLines = 0
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            textField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            textField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            
            iconImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            iconImage.widthAnchor.constraint(equalToConstant: 20),
            iconImage.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            
            descriptionLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct TextFieldWithCardCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            TextFieldWithCardCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
