//
//  ChangeConfirmPINViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import UIKit
import Combine

class ChangeConfirmPINViewController: UIViewController {
    
    private lazy var contentView = PINView(headingText: "Masukkan PIN Baru")
    private let viewModel: ChangePINViewModel = ChangePINViewModel()
    private var bindings = Set<AnyCancellable>()
    
    var oldPIN: String = ""
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ubah PIN"
        
        viewModel.oldPIN = self.oldPIN
        
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
                .assign(to: \.newPIN, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.changePINResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] isSuccess in
                    if isSuccess {
                        print("SUCCESS")
//                        self?.navigationController?.popToViewController(VC, animated: true)
                        
                        let viewControllers: [UIViewController] = self?.navigationController!.viewControllers ?? []
                        for aViewController in viewControllers {
                            print(aViewController)
                            if aViewController is ProfileViewController {
                                self?.navigationController!.popToViewController(aViewController, animated: true)
                            }
                        }
                        
                        self?.navigationController?.popToRootViewController(animated: true)
                    } else {
                        print("Something wrong, please try again later")
                    }
                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

//MARK: - Actions
extension ChangeConfirmPINViewController {
    @objc func PINFieldEdited(_ sender: UITextField) {
        // Limit 6 PIN length
        sender.text = sender.text![0..<6]
        contentView.pin = sender.text ?? ""
    }
}
