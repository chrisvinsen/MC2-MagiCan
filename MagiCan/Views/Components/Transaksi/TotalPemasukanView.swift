//
//  TotalPemasukanView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit

class TotalPemasukanView: UIView {
    
    var totalPemasukanIsSet = false
    
    lazy var totalPemasukanLabel = RegularLabel()
    lazy var totalPemasukanValue = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    private func addSubviews(){
        
        [totalPemasukanLabel, totalPemasukanValue]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        totalPemasukanValue.font = Font.headingSix.getUIFont
        
        totalPemasukanLabel.text = "Total Pemasukan"
        totalPemasukanValue.text = "Rp 0"
        
    }
    
    private func setUpConstraints(){
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 74),
            
            totalPemasukanLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            totalPemasukanLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            
            totalPemasukanValue.topAnchor.constraint(equalTo: totalPemasukanLabel.bottomAnchor, constant: 10),
            totalPemasukanValue.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15)
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct TotalPemasukanView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            TotalPemasukanView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
