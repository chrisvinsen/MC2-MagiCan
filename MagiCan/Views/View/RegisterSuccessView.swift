//
//  RegisterSuccessView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 05/07/22.
//

import UIKit

class RegisterSuccessView: UIView {
    
    lazy var imageView = UIImageView()
    lazy var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        [imageView, textLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setUpViews() {
        
        backgroundColor = .white
        
        imageView.image = UIImage.gifImageWithName("CheckmarkAnimation")
        imageView.contentMode = .scaleAspectFit
        
        textLabel.text = "Pendaftaran Selesai!"
        textLabel.font = Font.headingSix.getUIFont
        textLabel.textColor = UIColor.Neutral._90
        textLabel.textAlignment = .center
    }
    
    private func setUpConstraints() {
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -100),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            textLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
        ])
    }
    
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct RegisterSuccessView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            RegisterSuccessView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
