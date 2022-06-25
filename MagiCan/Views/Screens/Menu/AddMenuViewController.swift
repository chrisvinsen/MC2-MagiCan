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
                        print("ERROR")
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        self.dismiss(animated: true)
                        self.delegate.reloadDataTable()
                        
                        return
                    }
                } receiveValue: { [weak self] newMenu in
                    print("AFTER ADD MENU")
                    print(newMenu)
//                    print(self?.viewModel.base64Image)
                    if self?.viewModel.base64Image != "" {
                        print("REQUST ADD MENU IMAGES")
                        DispatchQueue.main.async {
                            sleep(1)
                            self?.viewModel.addMenuImage(menuId: newMenu._id)
                        }
                    }
                }
                .store(in: &bindings)
            
            viewModel.resultImage
                .sink { completion in
                    switch completion {
                    case .failure:
                        print("ERRORRRRR")
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        print("FINISHEEEEE")
//                        self.dismiss(animated: true)
//                        self.delegate.reloadDataTable()
                        
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
        print("Add Button Tapped")
        
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
        viewModel.addMenu()
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
}

//MARK: - Image
extension AddMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        print("A")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("B")
            let image = UIImagePickerController()
            image.delegate = self
            image.allowsEditing = true
            image.sourceType = .camera
            
            self.present(image, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        print("A")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            print("B")
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
