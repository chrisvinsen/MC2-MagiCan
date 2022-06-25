//
//  PINViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit
import Combine

class LoginPINViewController: UIViewController {
    
    private lazy var contentView = PINView()
    private let viewModel: LoginViewModel
    private var bindings = Set<AnyCancellable>()
    
    var username: String = ""
    
    var isLoginSuccess: Bool = false {
        didSet {
            
            if isLoginSuccess {
                self.contentView.warningLabel.text = ""
                
                let dashboardVC = UINavigationController(rootViewController: TempDashboardViewController())
                let transaksiVC = UINavigationController(rootViewController: TempDashboardViewController())
                let listMenuVC = UINavigationController(rootViewController: ListMenuViewController())

                dashboardVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icDashboard"), tag: 0)
                transaksiVC.tabBarItem = UITabBarItem(title: "Home", image:  UIImage(named: "icTransaksi"), tag: 1)
                listMenuVC.tabBarItem = UITabBarItem(title: "Menu", image:  UIImage(named: "icMenu"), tag: 2)
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [dashboardVC, transaksiVC, listMenuVC]
                tabBarController.modalPresentationStyle = .fullScreen
                UITabBar.appearance().tintColor = UIColor.Primary._30
                
                self.present(tabBarController, animated: true)
            }
            
            if !isLoginSuccess && viewModel.pin.count == 6 {
                self.contentView.pin = ""
                self.contentView.PINField.text = ""
                self.contentView.warningLabel.text = "PIN kamu tidak cocok. Ulangi PIN"
            }
        }
    }
    
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
        title = "Masukkan PIN"
        
        setUpTargets()
        setUpBindings()
        
        viewModel.username = username
    }
    
    private func setUpTargets() {
        contentView.PINField.addTarget(self, action: #selector(PINFieldEdited(_:)), for: .editingChanged)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            contentView.PINField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.pin, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$isLoginSuccess
                .assign(to: \.isLoginSuccess, on: self)
                .store(in: &bindings)
            
            viewModel.$pin
                .assign(to: \.pin, on: contentView)
                .store(in: &bindings)
            
            viewModel.loginResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        print("ERR")
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        print("SUCCS")
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
extension LoginPINViewController {
    @objc func PINFieldEdited(_ sender: UITextField) {
        // Limit 6 PIN length
        sender.text = sender.text![0..<6]
    }
}
