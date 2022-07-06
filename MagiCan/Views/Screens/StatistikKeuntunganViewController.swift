//
//  StatistikKeuntunganViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit
import Combine

class StatistikKeuntunganViewController: UIViewController {

    let statistikKeuntunganView = StatistikKeuntunganView()
    
    var transactionLists = [Transaction]() {
        didSet {
            DispatchQueue.main.async{
                self.statistikKeuntunganView.riwayatTable.reloadData()
            }
        }
    }
    
    var totalIncome: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
                var keuntungan = self.totalIncome - self.totalExpense
                self.statistikKeuntunganView.totalKeuntunganValue.text = keuntungan.formattedToRupiah
                
                if keuntungan > 0 {
                    self.statistikKeuntunganView.titleLabel.text = "Statistik Keuntungan"
                    self.statistikKeuntunganView.totalKeuntunganLabel.text = "Total Keuntungan"
                    self.statistikKeuntunganView.totalKeuntunganValue.textColor = UIColor.Primary._30
                } else {
                    self.statistikKeuntunganView.titleLabel.text = "Statistik Kerugian"
                    self.statistikKeuntunganView.totalKeuntunganLabel.text = "Total Kerugian"
                    self.statistikKeuntunganView.totalKeuntunganValue.textColor = UIColor.Error._30
                }
            }
        }
    }
    var totalExpense: Int64 = 0 {
        didSet {
            
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
    
    override func loadView() {
        view = statistikKeuntunganView
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let startDate = getDateString(date: getStartAndEndDateWithRange(range: 7).startDate)
        let endDate = getDateString(date: getStartAndEndDateWithRange(range: 7).endDate)
        viewModel.getTransactionList(startDate: startDate, endDate: endDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statistikKeuntunganView.riwayatTable.dataSource = self
        statistikKeuntunganView.riwayatTable.delegate = self
        
        view.backgroundColor = .white
        
        setUpTargets()
        setUpBindings()
        
        let startDate = getDateString(date: getStartAndEndDateWithRange(range: 7).startDate)
        let endDate = getDateString(date: getStartAndEndDateWithRange(range: 7).endDate)
        viewModel.getTransactionList(startDate: startDate, endDate: endDate)
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
        }
        
        func bindViewModelToView() {
            // Completion after load data
            viewModel.result
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] res in
                    print(res)
                }
                .store(in: &bindings)
        }
        
        bindViewModelToView()
        bindViewModelToController()
    }
}

extension StatistikKeuntunganViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statistikKeuntunganView.riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath) as! RiwayatTransaksiTableViewCell
        
        let transaction = self.transactionLists[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        
        cell.categoryTransaksi = ""
        
        cell.transaksiId.text = "Pengeluaran #\(String(format: "%04d", transaction.iterator))"
//        cell.transaksiDate.text = transaction.dateString
        cell.transaksiDate.text = transaction.date
//        cell.transaksiDate.text = dateFormatter.string(from: transaction.date)
        
        switch transaction.category {
        case TransactionCategory.Income.rawValue:
            cell.transaksiId.text = "Pemasukan #\(String(format: "%04d", transaction.iterator))"
            cell.transaksiAmount.text = "+ " + transaction.amount.formattedToRupiah
            
            switch transaction.type {
            case TransactionIncomeType.UpdateBalance.rawValue:
                cell.transaksiCategory.text = String(describing: TransactionIncomeType.UpdateBalance)
            case TransactionIncomeType.Offline.rawValue:
                cell.transaksiCategory.text = String(describing: TransactionIncomeType.Offline)
            case TransactionIncomeType.Online.rawValue:
                cell.transaksiCategory.text = String(describing: TransactionIncomeType.Online)
            default: break
            }
            
        case TransactionCategory.Expense.rawValue:
            cell.transaksiId.text = "Pengeluaran #\(String(format: "%04d", transaction.iterator))"
            cell.transaksiAmount.text = "- " + transaction.amount.formattedToRupiah
            
            switch transaction.type {
            case TransactionExpenseType.UpdateBalance.rawValue:
                cell.transaksiCategory.text = String(describing: TransactionExpenseType.UpdateBalance)
            case TransactionExpenseType.Pribadi.rawValue:
                cell.transaksiCategory.text = String(describing: TransactionExpenseType.Pribadi)
            case TransactionExpenseType.Usaha.rawValue:
                cell.transaksiCategory.text = String(describing: TransactionExpenseType.Usaha)
            default: break
            }
            
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statistikKeuntunganView.riwayatTable.deselectRow(at: indexPath, animated: false)
    }
}

extension StatistikKeuntunganViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikKeuntunganViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikKeuntunganViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
