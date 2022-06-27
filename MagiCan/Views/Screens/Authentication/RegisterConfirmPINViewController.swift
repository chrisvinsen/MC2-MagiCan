//
//  RegisterConfirmPINViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import UIKit
import Combine

class RegisterConfirmPINViewController: UIViewController {

    private lazy var contentView = PINView(headingText: "Konfirmasi PIN Baru")
    private let viewModel: RegisterViewModel
    private var bindings = Set<AnyCancellable>()
    
    var name: String = ""
    var username: String = ""
    var pin: String = ""
    
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
                let dashboardVC = UINavigationController(rootViewController: TempDashboardViewController())
                let transaksiVC = UINavigationController(rootViewController: TransactionListViewController())
                let listMenuVC = UINavigationController(rootViewController: ListMenuViewController())

                dashboardVC.tabBarItem = UITabBarItem(
                    title: "Dashboard",
                    image: UIImage(named: "icDashboard"),
                    selectedImage: UIImage(named: "icDashboardActive")
                )
                transaksiVC.tabBarItem = UITabBarItem(
                    title: "Transaksi",
                    image: UIImage(named: "icTransaction"),
                    selectedImage: UIImage(named: "icTransactionActive")
                )
                listMenuVC.tabBarItem = UITabBarItem(
                    title: "Menu",
                    image: UIImage(named: "icMenu"),
                    selectedImage: UIImage(named: "icMenuActive")
                )
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [dashboardVC, transaksiVC, listMenuVC]
                tabBarController.modalPresentationStyle = .fullScreen
                
                self.present(tabBarController, animated: true)
            }
            
            if !isRegisterSuccess && viewModel.pinConfirm.count == 6 {
                self.contentView.pin = ""
                self.contentView.PINField.text = ""
                self.contentView.warningLabel.text = "Terjadi kesalahan, silahkan coba lagi nanti"
            }
        }
    }
    
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
