//
//  GuestAddMenuViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit
import Combine
import UniformTypeIdentifiers

class GuestAddMenuViewController: UIViewController {
    
    private lazy var contentView = AddMenuView()
    
    var delegate: GuestListMenuDelegate!
    
    
    var base64Image: String = "" {
        didSet {
            self.contentView.base64Image = self.base64Image
        }
    }
    
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Tambah Menu"
        
        let leftBarButtonItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.tintColor = UIColor.Primary._30
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        setUpTargets()
    }
    
    private func setUpTargets() {
        contentView.addButton.addTarget(self, action: #selector(addButtonTapped(_ :)), for: .touchUpInside)
        contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
    }
}

// MARK: - Actions
extension GuestAddMenuViewController {
    
    @objc func addButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Pilih Foto", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { handler in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { handler in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { handler in
            self.openCamera()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        
        let nameVal = self.contentView.nameField.text
        let descVal = self.contentView.descriptionField.text
        let priceVal = Int64(self.contentView.priceField.text!) ?? 0
        
        if nameVal == "" {
            let alert = UIAlertController(title: "Mohon lengkapi semua data", message: "Nama menu tidak boleh kosong", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Baik", style: .default, handler: nil))

            self.present(alert, animated: true)
            
            return
        }
        
        delegate.addNewMenuData(newMenu: Menu(
            _id: "",
            name: nameVal!,
            description: descVal ?? "",
            imageUrl: self.base64Image,
            price: priceVal,
            isLoadingImage: false,
            isMenuChosen: false)
        )
        
        self.dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
}

//MARK: - Image
extension GuestAddMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let image = UIImagePickerController()
            image.delegate = self
            image.allowsEditing = true
            image.sourceType = .camera
            
            self.present(image, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let image = UIImagePickerController()
            image.allowsEditing = true
            image.sourceType = .photoLibrary
            image.delegate = self
            
            self.present(image, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        self.base64Image = image.base64 ?? ""
    }
}
