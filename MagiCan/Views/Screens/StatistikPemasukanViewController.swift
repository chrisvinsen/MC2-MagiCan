//
//  StatistikPemasukanViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit
import Combine

class StatistikPemasukanViewController: UIViewController {

    let statistikPemasukanView = StatistikPemasukanView(status: true)
    
    var transactionLists = [Transaction]() {
        didSet {
            DispatchQueue.main.async{
                self.statistikPemasukanView.riwayatTable.reloadData()
            }
        }
    }
    
    var totalIncome: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
                self.statistikPemasukanView.totalPemasukanValue.text = self.totalIncome.formattedToRupiah
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
        view = statistikPemasukanView
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTransactionList(category: "1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statistikPemasukanView.riwayatTable.dataSource = self
        statistikPemasukanView.riwayatTable.delegate = self
        
        view.backgroundColor = .white
        
        setUpTargets()
        setUpBindings()
        
        viewModel.getTransactionList(category: "1")
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

extension StatistikPemasukanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statistikPemasukanView.riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath) as! RiwayatTransaksiTableViewCell
        
        let transaction = self.transactionLists[indexPath.row]
        
        cell.categoryTransaksi = "Income"
        
        cell.transaksiId.text = "Pemasukan #\(String(format: "%04d", transaction.iterator))"
        cell.transaksiDate.text = transaction.dateString
        
        switch transaction.type {
        case TransactionIncomeType.UpdateBalance.rawValue:
            cell.transaksiCategory.text = String(describing: TransactionIncomeType.UpdateBalance)
        case TransactionIncomeType.Offline.rawValue:
            cell.transaksiCategory.text = String(describing: TransactionIncomeType.Offline)
        case TransactionIncomeType.Online.rawValue:
            cell.transaksiCategory.text = String(describing: TransactionIncomeType.Online)
        default: break
        }

        cell.transaksiAmount.text = "+ " + transaction.amount.formattedToRupiah
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statistikPemasukanView.riwayatTable.deselectRow(at: indexPath, animated: false)
    }
}

extension StatistikPemasukanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikPemasukanViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikPemasukanViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
