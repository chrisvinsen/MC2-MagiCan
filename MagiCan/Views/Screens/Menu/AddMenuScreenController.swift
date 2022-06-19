//
//  AddMenuScreenController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit

class AddMenuScreenController: UIViewController {
    
    let nameField = UITextField()
    let priceField = UITextField()
    let descriptionField = UITextField()
    let addButton = UIButton(type: .system)
    let previewImage = UIImageView()
    let saveButton = PrimaryButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu"
        
        let leftBarButtonItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.tintColor = UIColor.Primary._30
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        setupStyle()
        setupLayout()
    }
}

extension AddMenuScreenController {
    
    func setupStyle() {
        
        // Name Field
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Nama Menu",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        
        // Price Field
        priceField.translatesAutoresizingMaskIntoConstraints = false
        priceField.attributedPlaceholder = NSAttributedString(
            string: "Harga Satuan",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        
        // Description Field
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        descriptionField.attributedPlaceholder = NSAttributedString(
            string: "Deskripsi (Opsional)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Neutral._70]
        )
        
        // Add Button
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle(" Tambah Foto (Opsional)", for: .normal)
        addButton.tintColor = UIColor.Primary._30
        addButton.titleLabel?.font = Font.textSemiBold.getUIFont
        addButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped(_ :)), for: .touchUpInside)
        
        // Preview Image
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        previewImage.layer.cornerRadius = 8
        previewImage.clipsToBounds = true
        previewImage.image = UIImage(named: "SampleBakso.jpeg") //TEMP
        previewImage.contentMode = .scaleAspectFit
        
        // Save Button
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Simpan", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(nameField)
        view.addSubview(priceField)
        view.addSubview(descriptionField)
        view.addSubview(addButton)
        view.addSubview(previewImage)
        view.addSubview(saveButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
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

// MARK: - Actions
extension AddMenuScreenController {
    
    @objc func addButtonTapped(_ sender: UIButton) {
        print("Add Button Tapped")
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AddMenuScreenController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            AddMenuScreenController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
