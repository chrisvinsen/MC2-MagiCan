//
//  ChosenMenuCell.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit

class ChosenMenuCell: UITableViewCell {
    
    lazy var titleLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    lazy var stepperField = StepperField()
    
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
        
        [titleLabel, descriptionLabel, stepperField]
            .forEach {
                contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        
//        self.backgroundColor = .red
        
        titleLabel.text = "Bakso"
        titleLabel.font = Font.textBold.getUIFont
        titleLabel.textColor = UIColor.Neutral._90
        
        descriptionLabel.text = "@ Rp 15.000"
        descriptionLabel.font = Font.text.getUIFont
        descriptionLabel.textColor = UIColor.Neutral._70
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            
            descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            
            stepperField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
//            stepperField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stepperField.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            stepperField.widthAnchor.constraint(equalToConstant: 120),
   
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ChosenMenuCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            ChosenMenuCell().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
