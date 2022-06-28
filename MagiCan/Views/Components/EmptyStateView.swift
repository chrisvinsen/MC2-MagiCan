//
//  EmptyStateView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 28/06/22.
//

import UIKit

class EmptyStateView: UIView {
    
    lazy var imageView = UIImageView()
    lazy var titleLabel = HeadingFiveLabel()
    lazy var descLabel = RegularLabel()
    
    init(image: UIImage, title: String, desc: String) {
        super.init(frame: .zero)
        
        imageView.image = image
        titleLabel.text = title
        descLabel.text = desc
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        [imageView, titleLabel, descLabel]
            .forEach {
                self.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        self.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.textAlignment = .center
        
        descLabel.textAlignment = .center
    }
    
    func setUpConstraints() {
        
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            descLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct EmptyStateView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            EmptyStateView(image: UIImage(named: "EmptyMenu.png")!, title: "Daftar Menu Belum Tersedia", desc: "Daftar menu kamu masih kosong. Klik tombol + diatas untuk menambah menu baru").showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
