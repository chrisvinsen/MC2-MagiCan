//
//  AddTransactionExpenseViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit
import Combine

protocol AddTransactionExpenseProtocol {
    func updateTransactionType(data: KeyValue)
}

class AddTransactionExpenseViewController: UIViewController {
    
    var transactionDate: Date = Date() {
        didSet {
            self.contentView.dateField.tanggal.date = self.transactionDate
        }
    }
    
    var transactionType: Int = -1 {
        didSet {
            var transactionTypeName: String
            let transactionTypeDetails = TransactionExpenseTypeData.filter { $0.key as! Int == transactionType }
                
            if transactionTypeDetails.count > 0 {
                transactionTypeName = transactionTypeDetails[0].shortValue as! String
            } else {
                transactionTypeName = "Pilih Menu"
            }
            
            self.contentView.trxTypeButton.labelValue.text = transactionTypeName
        }
    }

    private lazy var contentView = AddTransactionExpenseView()
    private let viewModel = AddTransactionExpenseViewModel()
    private var bindings = Set<AnyCancellable>()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTargets()
        setUpBindings()
    }
    
    func setUpTargets() {
        self.contentView.trxTypeButton.addTarget(self, action: #selector(chooseTypeTapped(_ :)), for: .touchUpInside)
        self.contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
        self.contentView.dateField.tanggal.addTarget(self, action: #selector(dateFieldFilled(_ :)), for: .valueChanged)
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            
            contentView.totalAmountField.textField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.amountString, on: viewModel)
                .store(in: &bindings)
            
            contentView.descriptionField.textBox.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.description, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$transactionType
                .assign(to: \.transactionType, on: self)
                .store(in: &bindings)
            
            viewModel.$transactionDate
                .assign(to: \.transactionDate, on: self)
                .store(in: &bindings)
            
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
                } receiveValue: { [weak self] newMenu in

                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

// MARK: - Actions
extension AddTransactionExpenseViewController {
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        if viewModel.transactionType == -1 || viewModel.amountString == "" {
            // ALERT
            let alert = UIAlertController(title: "Mohon lengkapi semua data", message: "Tipe transaksi dan total pengeluaran tidak boleh kosong", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Baik", style: .default, handler: nil))

            self.present(alert, animated: true)
        } else {
            viewModel.addTransaction()
        }
    }
    
    @objc func chooseTypeTapped(_ sender: UIButton) {
        
        let VC = ChooseMenuViewController(type: ChooseMenuType.expense, tableDatas: TransactionExpenseTypeData)
        VC.title = "Tipe Pengeluaran"
        VC.delegateExpense = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func dateFieldFilled(_ sender: UIDatePicker) {
        
        viewModel.transactionDate = sender.date
    }
}

//MARK: - Custom Protocols
extension AddTransactionExpenseViewController: AddTransactionExpenseProtocol {
    
    func updateTransactionType(data: KeyValue) {
        viewModel.transactionType = data.key as! Int
    }
}
