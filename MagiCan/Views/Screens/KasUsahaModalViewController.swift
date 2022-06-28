//
//  KasUsahaModalViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 29/06/22.
//

import UIKit
import Combine

class KasUsahaModalViewController: UIViewController {
    
    let kasUsahaModal = KasUsahaModalView()
    private let viewModel: DashboardViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: DashboardViewModel = DashboardViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTargets()
        setUpBindings()
    }
    
    private func setUpTargets() {
        kasUsahaModal.cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_ :)), for: .touchUpInside)
        kasUsahaModal.saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            kasUsahaModal.kasEditField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.kasAmountEdit, on: viewModel)
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
                        self.dismiss(animated: true)
                        
                        return
                    }
                } receiveValue: { [weak self] user in
                }
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

extension KasUsahaModalViewController {
    @objc func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        viewModel.saveKasAmount()
    }
}
