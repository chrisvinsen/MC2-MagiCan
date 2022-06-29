//
//  ChangePINViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import UIKit
import Combine

class ChangePINViewController: UIViewController {

    private lazy var contentView = PINView(headingText: "Masukkan PIN Lama")
    private let viewModel: ChangePINViewModel = ChangePINViewModel()
    private var bindings = Set<AnyCancellable>()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Ubah PIN"
        
        setUpTargets()
        setUpBindings()
    }
    
    private func setUpTargets() {
        contentView.PINField.addTarget(self, action: #selector(PINFieldEdited(_ :)), for: .editingChanged)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            contentView.PINField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.oldPIN, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.validationResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] isValidated in
                    if isValidated {
                        let VC = ChangeConfirmPINViewController()
                        self?.navigationController?.pushViewController(VC, animated: true)
                        
                    } else {
                        self?.contentView.pin = ""
                        self?.contentView.PINField.text = ""
                        self?.contentView.warningLabel.text = "PIN Anda salah. Silahkan coba lagi."
                    }
                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

//MARK: - Actions
extension ChangePINViewController {
    @objc func PINFieldEdited(_ sender: UITextField) {
        // Limit 6 PIN length
        sender.text = sender.text![0..<6]
    }
}
