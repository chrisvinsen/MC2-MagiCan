//
//  RegisterScreenController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 16/06/22.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    private lazy var contentView = RegisterView()
    private let viewModel: RegisterViewModel
    private var bindings = Set<AnyCancellable>()
    var timer: Timer?

    init(viewModel: RegisterViewModel = RegisterViewModel()) {
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
            DispatchQueue.main.async {
                if self.viewModel.username == "" {
                    self.contentView.usernameField.updateStateDefault()
                    self.contentView.warningLabel.text = ""
                } else {
                    self.viewModel.checkUsernameValidity()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    private func setUpTargets() {
        contentView.continueButton.addTarget(self, action: #selector(continueButtonTapped(_ :)), for: .touchUpInside)
        contentView.loginButton.addTarget(self, action: #selector(loginButtonTapped(_ :)), for: .touchUpInside)
        
        contentView.nameField.addTarget(self, action: #selector(dismissKeyboard(_ :)), for: .editingDidEndOnExit)
        contentView.usernameField.addTarget(self, action: #selector(dismissKeyboard(_ :)), for: .editingDidEndOnExit)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            contentView.nameField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.name, on: viewModel)
                .store(in: &bindings)
            
            contentView.usernameField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.username, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$isUsernameValid
                .assign(to: \.isUsernameValid, on: contentView)
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
extension RegisterViewController {

    @objc func continueButtonTapped(_ sender: UIButton) {
        if viewModel.isUsernameValid {
            timer?.invalidate()
            timer = nil
            
            let vc = WelcomingAddMenuViewController()
            vc.name = viewModel.name
            vc.username = viewModel.username
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            contentView.continueButton.isEnabled = false
            contentView.usernameField.updateStateError()
            contentView.warningLabel.text = "Username tidak tersedia. Silakan mencoba username lain"
        }
    }

    @objc func loginButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func dismissKeyboard(_ sender: UITextField) { }
}

