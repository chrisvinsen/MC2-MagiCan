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
    func updateMenuChosen(menus: [Menu])
}

enum TransactionIncomeInput: Int {
    case ChooseMenu = 0
    case MenuChosen = 1
    case TotalAmount = 2
}

class AddTransactionIncomeViewController: UIViewController {
    
    var transactionDate: Date = Date() {
        didSet {
            self.contentView.dateField.tanggal.date = self.transactionDate
        }
    }
    
    var transactionType: Int = -1 {
        didSet {
            var transactionTypeName: String
            let transactionTypeDetails = TransactionIncomeTypeData.filter { $0.key as! Int == transactionType }
                
            if transactionTypeDetails.count > 0 {
                transactionTypeName = transactionTypeDetails[0].shortValue as! String
            } else {
                transactionTypeName = "Pilih Menu"
            }
            
            self.contentView.trxTypeButton.labelValue.text = transactionTypeName
        }
    }

    private lazy var contentView = AddTransactionIncomeView()
    private let viewModel = AddTransactionIncomeViewModel()
    private var bindings = Set<AnyCancellable>()
    
    var menusChosen = [MenuChosen]()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.isScrollEnabled = false
        
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
extension AddTransactionIncomeViewController {
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        if viewModel.transactionType == -1 || viewModel.amountString == "" {
            // ALERT
            let alert = UIAlertController(title: "Mohon lengkapi semua data", message: "Tipe transaksi dan total pemasukan tidak boleh kosong", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Baik", style: .default, handler: nil))

            self.present(alert, animated: true)
        } else {
            viewModel.addTransaction()
        }
    }
    
    @objc func chooseTypeTapped(_ sender: UIButton) {
        
        let VC = ChooseMenuViewController(type: ChooseMenuType.income, tableDatas: TransactionIncomeTypeData)
        VC.title = "Tipe Pemasukan"
        VC.delegateIncome = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func dateFieldFilled(_ sender: UIDatePicker) {
        
        viewModel.transactionDate = sender.date
    }
}

extension AddTransactionIncomeViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case TransactionIncomeInput.ChooseMenu.rawValue:
            return 1
        case TransactionIncomeInput.MenuChosen.rawValue:
            return menusChosen.count
        case TransactionIncomeInput.TotalAmount.rawValue:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case TransactionIncomeInput.ChooseMenu.rawValue:
            guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "ChooseMenuCell", for: indexPath) as? ChooseMenuCell else {fatalError("Unable to create menu cell")}
            cell.selectionStyle = .none
            
            return cell
        case TransactionIncomeInput.MenuChosen.rawValue:
            guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "ChosenMenuCell", for: indexPath) as? ChosenMenuCell else {fatalError("Unable to create menu cell")}
            cell.selectionStyle = .none
            
            cell.titleLabel.text = menusChosen[indexPath.row].name
            cell.descriptionLabel.text = "@ \(menusChosen[indexPath.row].price.formattedToRupiah)"
            cell.stepperField.textField.text = "\(menusChosen[indexPath.row].qty)"
            cell.stepperField.textField.tag = indexPath.row
            cell.stepperField.textField.delegate = self
            cell.stepperField.textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
            
            cell.stepperField.incrementButton.tag = indexPath.row
            cell.stepperField.incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
            
            cell.stepperField.decrementButton.tag = indexPath.row
            cell.stepperField.decrementButton.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)

            return cell
        case TransactionIncomeInput.TotalAmount.rawValue:
            guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "TextFieldWithCardCell", for: indexPath) as? TextFieldWithCardCell else {fatalError("Unable to create menu cell")}
            cell.selectionStyle = .none
            
            if menusChosen.count > 0 {
                cell.textField.isEnabled = false
                
                var totalAmount: Int64 = 0
                
                for menu in menusChosen {
                    totalAmount += (menu.price * Int64(menu.qty))
                }
                
                cell.textField.textField.text = "\(totalAmount.formattedToString)"
                
                viewModel.amountString = "\(totalAmount)"
                
            } else {
                cell.textField.isEnabled = true
            }
            
            cell.textField.textField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.amountString, on: viewModel)
                .store(in: &bindings)

            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case TransactionIncomeInput.ChooseMenu.rawValue:
            let VC = ListChooseMenuViewController(isLargeTitle: false)
            VC.title = "Daftar Menu"
            VC.delegate = self
            let navController = UINavigationController(rootViewController: VC)
            
            self.present(navController, animated: true)
        case TransactionIncomeInput.MenuChosen.rawValue:
            break
        case TransactionIncomeInput.TotalAmount.rawValue:
            break
        default:
            break
        }
    }
}

//MARK: - Actions
extension AddTransactionIncomeViewController {
    @objc func valueChanged(_ textField: UITextField) {
        let value = Int(textField.text!) ?? 0
        
        if value > 999 {
            textField.text = "999"
        } else if value < 0 {
            textField.text = "0"
        }
        
        
        menusChosen[textField.tag].qty = Int(textField.text!) ?? 0
        
        self.contentView.tableView.reloadSections(IndexSet(integer: TransactionIncomeInput.TotalAmount.rawValue), with: .fade)
    }
    
    @objc func incrementButtonTapped(_ button: UIButton) {
        
        self.menusChosen[button.tag].qty += 1
        
        self.contentView.tableView.reloadSections(IndexSet(integer: TransactionIncomeInput.TotalAmount.rawValue), with: .fade)
        self.contentView.tableView.reloadRows(at: [IndexPath(row: button.tag, section: TransactionIncomeInput.MenuChosen.rawValue)], with: .fade)
    }
    
    @objc func decrementButtonTapped(_ button: UIButton) {
        
        if self.menusChosen[button.tag].qty > 0 {
            self.menusChosen[button.tag].qty -= 1
        } else {
            self.menusChosen[button.tag].qty = 0
        }
        
        self.contentView.tableView.reloadSections(IndexSet(integer: TransactionIncomeInput.TotalAmount.rawValue), with: .fade)
        self.contentView.tableView.reloadRows(at: [IndexPath(row: button.tag, section: TransactionIncomeInput.MenuChosen.rawValue)], with: .fade)
    }
}

//MARK: - Custom Protocols
extension AddTransactionIncomeViewController: AddTransactionIncomeProtocol {
    
    func updateTransactionType(data: KeyValue) {
        viewModel.transactionType = data.key as! Int
    }
    
    func updateMenuChosen(menus: [Menu]) {
        
        menusChosen.removeAll()
        for menu in menus {
            menusChosen.append(MenuChosen(
                trxId: "",
                name: menu.name,
                description: menu.description,
                imageUrl: menu.imageUrl ?? "",
                menuId: menu._id,
                price: menu.price,
                qty: 1
            ))
        }
        
        self.contentView.tableView.reloadData()
    }
}
