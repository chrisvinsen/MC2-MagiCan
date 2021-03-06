//
//  RegisterConfirmPINViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import UIKit
import Combine

class RegisterConfirmPINViewController: UIViewController {

    private lazy var contentView = PINView(headingText: "Konfirmasi PIN", descriptionText: "Masukkan PIN yang sama dengan sebelumnya.")
    private let viewModel: RegisterViewModel = RegisterViewModel()
    private var bindings = Set<AnyCancellable>()
    
    var name, username, pin: String
    var guestMenu = [Menu]()
    
    init(name: String, username: String, pin: String) {
        self.name = name
        self.username = username
        self.pin = pin
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isPinMatch: Bool = false {
        didSet {
            if isPinMatch {
                self.contentView.warningLabel.text = ""
                
                viewModel.register()
            }
            
            if !isPinMatch && viewModel.pinConfirm.count == 6 {
                self.contentView.pin = ""
                self.contentView.PINField.text = ""
                self.contentView.warningLabel.text = "PIN kamu tidak cocok. Ulangi PIN"
            }
        }
    }
    
    var isRegisterSuccess: Bool = false {
        didSet {
            if isRegisterSuccess {
                if guestMenu.count > 0 {
                    viewModel.guestMenu = self.guestMenu
                    viewModel.addMenu()
                }
                
                let vc = RegisterSuccessViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: true)
            }
            
            if !isRegisterSuccess && viewModel.pinConfirm.count == 6 {
                self.contentView.pin = ""
                self.contentView.PINField.text = ""
                self.contentView.warningLabel.text = "Terjadi kesalahan, silahkan coba lagi nanti"
            }
        }
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.name = name
        viewModel.username = username
        viewModel.pin = pin
        
        view.backgroundColor = .white
        title = "Buat PIN"
        
        setUpTargets()
        setUpBindings()
    }
    
    private func setUpTargets() {
        contentView.PINField.addTarget(self, action: #selector(PINFieldEdited(_:)), for: .editingChanged)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            contentView.PINField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.pinConfirm, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$isPinMatch
                .assign(to: \.isPinMatch, on: self)
                .store(in: &bindings)
            
            viewModel.$isRegisterSuccess
                .assign(to: \.isRegisterSuccess, on: self)
                .store(in: &bindings)
            
            viewModel.$pinConfirm
                .assign(to: \.pin, on: contentView)
                .store(in: &bindings)
            
            viewModel.registerResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] res in
                    print(res)
                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

//MARK: - Actions
extension RegisterConfirmPINViewController {
    @objc func PINFieldEdited(_ sender: UITextField) {
        // Limit 6 PIN length
        sender.text = sender.text![0..<6]
    }
}
