//
//  LoginViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    private lazy var contentView = LoginView()
    private let viewModel: LoginViewModel
    private var bindings = Set<AnyCancellable>()
    var timer: Timer?

    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Masuk"        
        
        setUpTargets()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            DispatchQueue(label: "LoginViewController:checkUsernameExists").async {
                self.viewModel.checkUsernameExists()
            }
        }
    }
    
    private func setUpTargets() {
        contentView.usernameField.addTarget(self, action: #selector(dismissKeyboard(_ :)), for: .editingDidEndOnExit)
        contentView.loginButton.addTarget(self, action: #selector(loginButtonTapped(_ :)), for: .touchUpInside)
        contentView.registerButton.addTarget(self, action: #selector(registerButtonTapped(_ :)), for: .touchUpInside)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            contentView.usernameField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.username, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$isUsernameExists
                .assign(to: \.isUsernameExists, on: contentView)
                .store(in: &bindings)
            
            viewModel.validationResult
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

// MARK: - Actions
extension LoginViewController {

    @objc func loginButtonTapped(_ sender: UIButton) {
        
        if viewModel.isUsernameExists {
            contentView.usernameField.updateStateDefault()
            contentView.warningLabel.text = ""
            
            timer?.invalidate()
            viewModel.isUsernameExists = false
            
            let vc = LoginPINViewController()
            vc.username = viewModel.username
            navigationController?.pushViewController(vc, animated: true)
        } else {
            if contentView.usernameField.text != "" {
                contentView.usernameField.updateStateError()
                contentView.warningLabel.text = "Username tidak ditemukan, silahkan daftar untuk pengguna baru"
            }
        }
    }

    @objc func registerButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func dismissKeyboard(_ sender: UITextField) { }
}

