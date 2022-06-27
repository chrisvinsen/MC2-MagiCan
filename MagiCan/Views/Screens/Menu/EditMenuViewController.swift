//
//  EditMenuViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit
import Combine
import UniformTypeIdentifiers

class EditMenuViewController: UIViewController {
    
    private lazy var contentView = AddMenuView()
    private let viewModel: EditMenuViewModel
    private var bindings = Set<AnyCancellable>()
    
    var delegate: ListMenuDelegate!
    
    
    init(menu: Menu) {
        self.viewModel = EditMenuViewModel()
        self.viewModel._id = menu._id
        self.viewModel.base64Image = menu.imageUrl ?? ""
        self.viewModel.name = menu.name
        self.viewModel.description = menu.description
        self.viewModel.priceString = String(menu.price)
        
        super.init(nibName: nil, bundle: nil)
        
        self.contentView.nameField.text = menu.name
        self.contentView.descriptionField.text = menu.description
        self.contentView.priceField.text = String(menu.price)        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Menu"
        
        let leftBarButtonItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.tintColor = UIColor.Primary._30
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        setUpTargets()
        setUpBindings()
    }
    
    private func setUpTargets() {
        contentView.addButton.addTarget(self, action: #selector(addButtonTapped(_ :)), for: .touchUpInside)
        contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            contentView.nameField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.name, on: viewModel)
                .store(in: &bindings)
            
            contentView.priceField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.priceString, on: viewModel)
                .store(in: &bindings)
            
            contentView.descriptionField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.description, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$base64Image
                .assign(to: \.base64Image, on: contentView)
                .store(in: &bindings)
            
            viewModel.result
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        self.dismiss(animated: true)
                        
                        return
                    }
                } receiveValue: { [weak self] newMenu in
                    print("UPDATE \(newMenu)")
                    var updateMenu = newMenu
                    updateMenu.imageUrl = self?.viewModel.base64Image ?? ""
                    updateMenu.isLoadingImage = true
                    print("UPDATE NEW \(updateMenu)")
                    self?.delegate.updateMenuData(newMenu: updateMenu)
                    
                    DispatchQueue.main.async {
                        self?.viewModel.addUpdateMenuImage(menuId: newMenu._id)
                    }
                    
                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

// MARK: - Actions
extension EditMenuViewController {
    
    @objc func addButtonTapped(_ sender: UIButton) {
        print("Add Button Tapped")
        
        let alert = UIAlertController(title: "Pilih Foto", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Buka Kamera", style: .default, handler: { handler in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Buka Galeri", style: .default, handler: { handler in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Hapus Foto", style: .destructive, handler: { handler in
            self.deleteImage()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { handler in
            self.openCamera()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        viewModel.updateMenu()
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
}

//MARK: - Image
extension EditMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    func deleteImage() {
        self.viewModel.base64Image = ""
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        self.viewModel.base64Image = image.base64 ?? ""
    }
}
