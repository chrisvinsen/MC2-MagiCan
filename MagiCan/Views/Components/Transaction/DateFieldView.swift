//
//  DateFieldView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//


import UIKit

class DateFieldView: UIView {
    
    lazy var sectionLabel = UILabel()
    lazy var tanggal = UIDatePicker()
    lazy var dividerTop = UIView()
    lazy var dividerBottom = UIView()
    
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
        [sectionLabel, tanggal, dividerTop, dividerBottom]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        sectionLabel.text = "Tanggal"
        
//        tanggalLabel.text = "7 Jun 2022"
        
        sectionLabel.font = Font.textBold.getUIFont
        tanggal.datePickerMode = .date
        
//        tanggalLabel.font = UIFont(name: "Inter-Medium", size: 12)
//        tanggalLabel.font = UIFont(name: "Inter-Medium", size: 12)
//        tanggalLabel.textColor = UIColor(red: 0.255, green: 0.255, blue: 0.255, alpha: 1)
//        tanggalLabel.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 0.5)
//        tanggalLabel.textAlignment = .center
//        tanggalLabel.layer.masksToBounds = true
//        tanggalLabel.layer.cornerRadius = 10
        
        dividerTop.backgroundColor = UIColor.Neutral._50
        dividerBottom.backgroundColor = UIColor.Neutral._50
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 48),
            
            dividerTop.topAnchor.constraint(equalTo: self.topAnchor),
            dividerTop.leftAnchor.constraint(equalTo: self.leftAnchor),
            dividerTop.rightAnchor.constraint(equalTo: self.rightAnchor),
            dividerTop.heightAnchor.constraint(equalToConstant: 1),
            
            sectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            tanggal.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tanggal.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            dividerBottom.topAnchor.constraint(equalTo: self.bottomAnchor),
            dividerBottom.leftAnchor.constraint(equalTo: self.leftAnchor),
            dividerBottom.rightAnchor.constraint(equalTo: self.rightAnchor),
            dividerBottom.heightAnchor.constraint(equalToConstant: 1),
            
//
//            tanggal.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
//            tanggal.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
//            tanggal.widthAnchor.constraint(equalToConstant: 100),
//            tanggal.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct DateFieldView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            DateFieldView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
