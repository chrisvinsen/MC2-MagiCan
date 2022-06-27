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

    private lazy var contentView = AddTransactionExpenseView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTargets()
    }
    
    func setUpTargets() {
        self.contentView.trxTypeButton.addTarget(self, action: #selector(chooseTypeTapped(_ :)), for: .touchUpInside)
        self.contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
    }
}

// MARK: - Actions
extension AddTransactionExpenseViewController {
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        print("SAVE TAPPED")
    }
    
    @objc func chooseTypeTapped(_ sender: UIButton) {
        
        let VC = ChooseMenuViewController(type: ChooseMenuType.expense, tableDatas: TransactionExpenseTypeData)
        VC.title = "Tipe Pengeluaran"
        VC.delegateExpense = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
}

//MARK: - Custom Protocols
extension AddTransactionExpenseViewController: AddTransactionExpenseProtocol {
    
    func updateTransactionType(data: KeyValue) {
        print("UPDATE EXPENSE TYPE")
        print(data)
        self.contentView.trxTypeButton.labelValue.text = data.shortValue as! String
    }
}
