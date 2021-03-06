//
//  StatistikPengeluaranViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit
import Combine

class StatistikPengeluaranViewController: UIViewController {

    let statistikPengeluaranView = StatistikPengeluaranView(status: true)
    
    var transactionLists = [Transaction]() {
        didSet {
            DispatchQueue.main.async{
                self.statistikPengeluaranView.riwayatTable.reloadData()
            }
        }
    }
    
    var totalExpense: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
//                var summary = getTransactionSummaryFromList(transactionLists: self.transactionLists)
//                self.statistikPengeluaranView.totalPengeluaranValue.text = summary.totalExpense.formattedToRupiah
                self.statistikPengeluaranView.totalPengeluaranValue.text = self.totalExpense.formattedToRupiah
            }
        }
    }
    
    private let viewModel: ListRiwayatTransaksiViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: ListRiwayatTransaksiViewModel = ListRiwayatTransaksiViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = statistikPengeluaranView
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let startDate = getDateString(date: getStartAndEndDateWithRange(range: 7).startDate)
        let endDate = getDateString(date: getStartAndEndDateWithRange(range: 7).endDate)
        viewModel.getTransactionList(category: "2", startDate: startDate, endDate: endDate)
//        print("ini isi parameter:", startDate, endDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statistikPengeluaranView.riwayatTable.dataSource = self
        statistikPengeluaranView.riwayatTable.delegate = self
        
        view.backgroundColor = .white
        
        setUpTargets()
        setUpBindings()
        
        let startDate = getDateString(date: getStartAndEndDateWithRange(range: 7).startDate)
        let endDate = getDateString(date: getStartAndEndDateWithRange(range: 7).endDate)
        viewModel.getTransactionList(category: "2", startDate: startDate, endDate: endDate)
    }
    
    private func setUpTargets() {
        
    }
    
    private func setUpBindings() {

        func bindViewModelToController() {
            viewModel.$transactionLists
                .assign(to: \.transactionLists, on: self)
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

extension StatistikPengeluaranViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statistikPengeluaranView.riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath) as! RiwayatTransaksiTableViewCell
        
        let transaction = self.transactionLists[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        
        cell.categoryTransaksi = "Expense"
        
        cell.transaksiId.text = "Pengeluaran #\(String(format: "%04d", transaction.iterator))"
//        cell.transaksiDate.text = transaction.dateString
        cell.transaksiDate.text = transaction.date
//        cell.transaksiDate.text = dateFormatter.string(from: transaction.date)
        
        switch transaction.type {
        case TransactionExpenseType.Pribadi.rawValue:
            cell.transaksiCategory.text = String(describing: TransactionExpenseType.Pribadi)
        case TransactionExpenseType.Usaha.rawValue:
            cell.transaksiCategory.text = String(describing: TransactionExpenseType.Usaha)
        default:
            cell.transaksiCategory.text = "Kas Usaha"
        }

        cell.transaksiAmount.text = "- " + transaction.amount.formattedToRupiah
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statistikPengeluaranView.riwayatTable.deselectRow(at: indexPath, animated: false)
    }
}

extension StatistikPengeluaranViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikPengeluaranViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikPengeluaranViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
