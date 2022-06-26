//
//  AddTransactionIncomeViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit
import Combine

class AddTransactionIncomeViewController: UIViewController {

    private lazy var contentView = AddTransactionIncomeView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("A")
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.isScrollEnabled = false
        contentView.tableView.bounces = false
        
//        contentView.tableView.reloadData()

        // Do any additional setup after loading the view.
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

