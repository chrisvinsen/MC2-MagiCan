//
//  ChooseMenuViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import UIKit

enum ChooseMenuType {
    case income
    case expense
}

class ChooseMenuViewController: UIViewController {
    
    let type: ChooseMenuType
    private lazy var contentView = ChooseMenuView()
    let masterTableDatas: [KeyValue]
    var tableDatas: [KeyValue]
    
    var delegateIncome: AddTransactionIncomeProtocol?
    var delegateExpense: AddTransactionExpenseProtocol?
    
    init(type: ChooseMenuType, tableDatas: [KeyValue]) {
        self.type = type
        self.masterTableDatas = tableDatas
        self.tableDatas = tableDatas
        
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
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = UIColor.Primary._30
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        self.contentView.tableView.delegate = self
        self.contentView.tableView.dataSource = self
    }
}

extension ChooseMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.contentView.tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath) as? ChecklistCell else {fatalError("Unable to create menu cell")}
        
        cell.nameLabel.text = tableDatas[indexPath.row].value as! String
        cell.isChecked = tableDatas[indexPath.row].status

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableDatas = masterTableDatas
        tableDatas[indexPath.row].status = true
        tableView.reloadData()
        
        switch self.type {
        case .income:
            self.delegateIncome?.updateTransactionType(data: self.tableDatas[indexPath.row])
        case .expense:
            self.delegateExpense?.updateTransactionType(data: self.tableDatas[indexPath.row])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.dismiss(animated: true)
        }
        
    }
}

//MARK: - Actions
extension ChooseMenuViewController {
    
    @objc func backButtonTapped() {
        print("SAVE HERE")
        self.dismiss(animated: true)
    }
}
