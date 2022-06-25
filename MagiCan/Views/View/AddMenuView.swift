//
//  AddMenuView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import UIKit

class AddMenuView: UIView {
    
    lazy var nameField = UITextField()
    lazy var priceField = UITextField()
    lazy var descriptionField = UITextField()
    lazy var addButton = UIButton(type: .system)
    lazy var previewImage = UIImageView()
    lazy var saveButton = PrimaryButton()
    
    var base64Image: String = "" {
        didSet {
            if base64Image != "" {
                addButton.setTitle(" Ubah Foto (Opsional)", for: .normal)
                previewImage.image = base64Image.imageFromBase64
            } else {
                addButton.setTitle(" Tambah Foto (Opsional)", for: .normal)
                previewImage.image = nil
            }
        }
    }
    
    var isUsernameExists: Bool = false
    
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
        
        [nameField, priceField, descriptionField, addButton, previewImage, saveButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        // Name Field
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Nama Menu",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        
        // Price Field
        priceField.attributedPlaceholder = NSAttributedString(
            string: "Harga Satuan",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        priceField.keyboardType = .numberPad
        
        // Description Field
        descriptionField.attributedPlaceholder = NSAttributedString(
            string: "Deskripsi (Opsional)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        
        // Add Button
        addButton.setTitle(" Tambah Foto (Opsional)", for: .normal)
        addButton.tintColor = UIColor.Primary._30
        addButton.titleLabel?.font = Font.textSemiBold.getUIFont
        addButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        
        // Preview Image
        previewImage.layer.cornerRadius = 8
        previewImage.clipsToBounds = true
        previewImage.contentMode = .scaleAspectFit
        
        // Save Button
        saveButton.setTitle("Simpan", for: .normal)
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Name Field
            nameField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            nameField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 44),
            
            // Price Field
            priceField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            priceField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            priceField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            priceField.heightAnchor.constraint(equalToConstant: 44),
            
            // Description Field
            descriptionField.topAnchor.constraint(equalTo: priceField.bottomAnchor, constant: 15),
            descriptionField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            descriptionField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            descriptionField.heightAnchor.constraint(equalToConstant: 44),
            
            // Add Button
            addButton.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 15),
            addButton.heightAnchor.constraint(equalToConstant: 48),
            addButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            
            // Preview Image
            previewImage.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15),
            previewImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            previewImage.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5, constant: -20),
            previewImage.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5, constant: -20),
            
            // Save Button
            saveButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            saveButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AddMenuView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            AddMenuView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
