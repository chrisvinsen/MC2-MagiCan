//
//  AddMenuViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit
import Combine
import UniformTypeIdentifiers

class AddMenuViewController: UIViewController {
    
    private lazy var contentView = AddMenuView()
    private let viewModel: AddMenuViewModel
    private var bindings = Set<AnyCancellable>()
    
    var delegate: ListMenuDelegate!
    
    
    init(viewModel: AddMenuViewModel = AddMenuViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        title = "Tambah Menu"
        
        let leftBarButtonItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.tintColor = UIColor.Primary._30
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        setUpTargets()
        setUpBindings()
    }
    
    private func setUpTargets() {
        contentView.addButton.addTarget(self, action: #selector(addButtonTapped(_ :)), for: .touchUpInside)
        contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
        
        contentView.nameField.addTarget(self, action: #selector(dismissKeyboard(_ :)), for: .editingDidEndOnExit)
        contentView.priceField.addTarget(self, action: #selector(dismissKeyboard(_ :)), for: .editingDidEndOnExit)
        contentView.descriptionField.addTarget(self, action: #selector(dismissKeyboard(_ :)), for: .editingDidEndOnExit)
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

                    self?.delegate.addNewMenuData(newMenu: Menu(
                        _id: "",
                        name: newMenu.name,
                        description: newMenu.description,
                        imageUrl: self?.viewModel.base64Image ?? "",
                        price: newMenu.price,
                        isLoadingImage: true
                    ))
                    
                    if self?.viewModel.base64Image != "" {
                        DispatchQueue.main.async {
                            self?.viewModel.addUpdateMenuImage(menuId: newMenu._id)
                        }
                    }
                }
                .store(in: &bindings)
            
            viewModel.resultImage
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        
                        return
                    }
                } receiveValue: { [weak self] newMenu in
                    print(newMenu)
                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

// MARK: - Actions
extension AddMenuViewController {
    
    @objc func addButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Pilih Foto", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Buka Kamera", style: .default, handler: { handler in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Buka Galeri", style: .default, handler: { handler in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { handler in
            self.openCamera()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        viewModel.addMenu()
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func dismissKeyboard(_ sender: UITextField) { }
    
}

//MARK: - Image
extension AddMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        self.viewModel.base64Image = image.base64 ?? ""
    }
}
