//
//  ProfileViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    var name: String = "" {
        didSet {
            self.contentView.userCard.nameLabel.text = name
        }
    }
    var username: String = "" {
        didSet {
            self.contentView.userCard.usernameLabel.text = "@\(username)"
        }
    }
    
    private lazy var contentView = ProfileView()
    private let viewModel: ProfileViewModel
    private var bindings = Set<AnyCancellable>()

    init(viewModel: ProfileViewModel = ProfileViewModel()) {
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
        super.viewWillAppear(animated)
        
        viewModel.getUserDetail()
    }
    
    private func setUpTargets() {
        contentView.userCard.buttonEdit.addTarget(self, action: #selector(updateDataButtonTapped(_ :)), for: .touchUpInside)
        contentView.changePINButton.addTarget(self, action: #selector(changePINButtonTapped(_ :)), for: .touchUpInside)
        contentView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped(_ :)), for: .touchUpInside)
    }
    
    private func setUpBindings() {
        func bindViewModelToController() {
            viewModel.$name
                .assign(to: \.name, on: self)
                .store(in: &bindings)
            
            viewModel.$username
                .assign(to: \.username, on: self)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {

            viewModel.result
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
        
        bindViewModelToController()
        bindViewModelToView()
    }
}

// MARK: - Actions
extension ProfileViewController {
    
    @objc func updateDataButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Ubah Nama Usaha", message: "Masukkan nama usaha baru kamu", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }

        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: { [weak alert] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Simpan", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            let name = textField?.text ?? ""
            if name != "" {
                self.viewModel.updateData(req: UserUpdateDataRequest(name: name))
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }

    @objc func changePINButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Fitur sedang dalam pengembangan", message: "Maaf atas ketidaknyamanannya", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Oke, Gapapa", style: .default, handler: nil))

        self.present(alert, animated: true)
        
//        let VC = ChangePINViewController()
//        self.navigationController?.pushViewController(VC, animated: true)
    }

    @objc func logoutButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Keluar dari Akun?", message: "Anda akan keluar dari akun ini dan akan diarahkan ke halaman awal", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: { [weak alert] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { [weak alert] (_) in
            let vc = OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true)
            
            self.viewModel.logout()
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

