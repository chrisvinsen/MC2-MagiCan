//
//  AddTransactionIncomeViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit
import Combine

protocol AddTransactionIncomeProtocol {
    func updateTransactionType(data: KeyValue)
}

class AddTransactionIncomeViewController: UIViewController {

    private lazy var contentView = AddTransactionIncomeView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.isScrollEnabled = false
        
        setUpTargets()
    }
    
    func setUpTargets() {
        self.contentView.trxTypeButton.addTarget(self, action: #selector(chooseTypeTapped(_ :)), for: .touchUpInside)
        self.contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
    }
}

// MARK: - Actions
extension AddTransactionIncomeViewController {
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        print("SAVE TAPPED")
    }
    
    @objc func chooseTypeTapped(_ sender: UIButton) {
        
        let VC = ChooseMenuViewController(type: ChooseMenuType.income, tableDatas: TransactionIncomeTypeData)
        VC.title = "Tipe Pemasukan"
        VC.delegateIncome = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
}

extension AddTransactionIncomeViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "ChooseMenuCell", for: indexPath) as? ChooseMenuCell else {fatalError("Unable to create menu cell")}
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "ChosenMenuCell", for: indexPath) as? ChosenMenuCell else {fatalError("Unable to create menu cell")}
            cell.selectionStyle = .none
            cell.stepperField.textField.tag = indexPath.row
            cell.stepperField.textField.delegate = self
            cell.stepperField.textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
            
            return cell
        } else {
            guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "TextFieldWithCardCell", for: indexPath) as? TextFieldWithCardCell else {fatalError("Unable to create menu cell")}
            cell.selectionStyle = .none

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
}

//MARK: - Actions
extension AddTransactionIncomeViewController {
    @objc func valueChanged(_ textField: UITextField) {
            
        print("TAG: \(textField.tag) WITH VALUE \(textField.text)")
    }
}

//MARK: - Custom Protocols
extension AddTransactionIncomeViewController: AddTransactionIncomeProtocol {
    
    func updateTransactionType(data: KeyValue) {
        print(data)
        print("UPDATE INCOME TYPE")
        self.contentView.trxTypeButton.labelValue.text = data.shortValue as! String
    }
}
