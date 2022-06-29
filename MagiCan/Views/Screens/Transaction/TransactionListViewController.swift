//
//  TransactionListViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit
import Combine

protocol TransactionListViewDelegate {
    func reloadDataTable()
}

class TransactionListViewController: UIViewController {
    
    private lazy var contentView = TransactionListView()
    private lazy var emptyContentView = EmptyStateView(image: UIImage(named: "EmptyTransaction.png")!, title: "Tidak Ada Transaksi", desc: "Transaksi kamu masih kosong nih. Klik tombol + diatas untuk menambah transaksi baru")
    
    var transactionLists = [Transaction]() {
        didSet {
            
            DispatchQueue.main.async{
                if self.transactionLists.count > 0 {
                    self.view = self.contentView
                    self.contentView.tableView.reloadData()
                } else {
                    self.view = self.emptyContentView
                }
            }
        }
    }
    var totalIncome: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
                self.contentView.summaryCard.jumlahPemasukanLabel.text = self.totalIncome.formattedToRupiah
            }
        }
    }
    var totalExpense: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
                self.contentView.summaryCard.jumlahPengeluaranLabel.text = self.totalExpense.formattedToRupiah
            }
        }
    }
    var totalProfit: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
                self.contentView.summaryCard.keuntunganLabel.text = self.totalProfit.formattedToRupiah
            }
        }
    }
    
    private let viewModel: TransactionListViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: TransactionListViewModel = TransactionListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func loadView() {
//        view = contentView
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTransactionList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        title = "Transaksi"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let icon = UIImage(systemName: "plus.circle.fill")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        navigationItem.rightBarButtonItem = barButton
        
        setUpTargets()
        setUpBindings()
        
        viewModel.getTransactionList()
    }
    
    private func setUpTargets() {
        
    }
    
    private func setUpBindings() {

        func bindViewModelToController() {
            viewModel.$transactionLists
                .assign(to: \.transactionLists, on: self)
                .store(in: &bindings)
            
            viewModel.$totalIncome
                .assign(to: \.totalIncome, on: self)
                .store(in: &bindings)
            
            viewModel.$totalExpense
                .assign(to: \.totalExpense, on: self)
                .store(in: &bindings)
            
            viewModel.$totalProfit
                .assign(to: \.totalProfit, on: self)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            // Completion after load data
            viewModel.result
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        print("FAILURE")
                        return
                    case .finished:
                        print("FINISHED")
                        return
                    }
                } receiveValue: { [weak self] res in
                    print(res)
                }
                .store(in: &bindings)
            
            // Completion after delete data
            viewModel.deleteResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] message in
                    
                }
                .store(in: &bindings)
        }
        
//        bindViewToViewModel()
        bindViewModelToView()
        bindViewModelToController()
    }
}

//MARK: - Action
extension TransactionListViewController {
    @objc func addButtonTapped() {
        let VC = AddTransactionViewController()
        VC.delegate = self
        VC.title = "Transaksi Baru"
//        VC.delegate = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
}

//MARK: - Table
extension TransactionListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.transactionLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = contentView.tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as? TransactionCell else {fatalError("Unable to create menu cell")}
        
        let transaction = self.transactionLists[indexPath.row]
        
        switch transaction.category {
        case TransactionCategory.Income.rawValue:
            
            cell.isIncome = true
            cell.titleLabel.text = "Pemasukan #\(String(format: "%04d", transaction.iterator))"
            cell.amountLabel.text = "+ \(transaction.amount.formattedToRupiah)"
            
            switch transaction.type {
            case TransactionIncomeType.Offline.rawValue:
                cell.typeLabel.text = String(describing: TransactionIncomeType.Offline)
            case TransactionIncomeType.Online.rawValue:
                cell.typeLabel.text = String(describing: TransactionIncomeType.Online)
            default:
                cell.typeLabel.text = "Kas Usaha"
            }
            
        case TransactionCategory.Expense.rawValue:
            
            cell.isIncome = false
            cell.titleLabel.text = "Pengeluaran #\(String(format: "%04d", transaction.iterator))"
            cell.amountLabel.text = "- \(transaction.amount.formattedToRupiah)"
            
            switch transaction.type {
            case TransactionExpenseType.Pribadi.rawValue:
                cell.typeLabel.text = String(describing: TransactionExpenseType.Pribadi)
            case TransactionExpenseType.Usaha.rawValue:
                cell.typeLabel.text = String(describing: TransactionExpenseType.Usaha)
            default:
                cell.typeLabel.text = "Kas Usaha"
            }
            
        default: break
        }
        
        cell.dateLabel.text = transaction.dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Hapus") {
            (action, sourceView, completionHandler) in
            
            let thisTrx = self.transactionLists[indexPath.row]
            
            self.viewModel.deleteTransaction(idToDelete: thisTrx._id)
            
//            if let idx = self.viewModel.transactionLists.firstIndex(where: { $0._id == self.transactionLists[indexPath.row]._id }) {
            self.viewModel.transactionLists.remove(at: indexPath.row)
            
            switch thisTrx.category {
            case TransactionCategory.Income.rawValue:
                self.viewModel.totalIncome -= thisTrx.amount
                self.viewModel.totalProfit -= thisTrx.amount
            case TransactionCategory.Expense.rawValue:
                self.viewModel.totalExpense -= thisTrx.amount
                self.viewModel.totalProfit += thisTrx.amount
            default: break
            }
//            }

            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.Error._50
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        // Delete should not delete automatically
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
}

extension TransactionListViewController: TransactionListViewDelegate {
    
    func reloadDataTable() {
        viewModel.getTransactionList()
    }
}
