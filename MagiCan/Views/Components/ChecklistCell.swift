//
//  ChecklistCell.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import UIKit

class ChecklistCell: UITableViewCell {
    
    var name: String = "Default Name"
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                iconImage.image = UIImage(systemName: "checkmark")
            } else {
                iconImage.image = nil
            }
        }
    }
    
    lazy var nameLabel = UILabel()
    lazy var iconImage = UIImageView()
    
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
        
        [nameLabel, iconImage]
            .forEach {
                contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
        // Icon Image
        iconImage.contentMode = .scaleAspectFill
        
        // Name Label
        nameLabel.text = self.name
        nameLabel.numberOfLines = 1
        nameLabel.textColor = UIColor.Neutral._90
        nameLabel.font = Font.textRegular.getUIFont
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
//            Name Label
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: iconImage.leadingAnchor, constant: -10),
            
//            Icon Image
            iconImage.widthAnchor.constraint(equalToConstant: 20),
            iconImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            iconImage.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ChecklistCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            ChecklistCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
