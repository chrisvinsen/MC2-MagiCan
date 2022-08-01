//
//  TransactionListViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation
import Combine


final class TransactionListViewModel {
    @Published var transactionLists: [Transaction] = []
    @Published var totalIncome: Int64 = 0
    @Published var totalExpense: Int64 = 0
    @Published var totalProfit: Int64 = 0
    
    var result = PassthroughSubject<Void, Error>()
    var deleteResult = PassthroughSubject<Void, Error>()
    
    private let transactionService: TransactionServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(transactionService: TransactionServiceProtocol = TransactionService()) {
        self.transactionService = transactionService
    }
    
    //MARK: - Get Transaction List
    func getTransactionList(startDate: String, endDate: String) {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                self?.result.send(())
            }
        }
        
        let valueHandler: ([Transaction]) -> Void = { [weak self] transactionLists in
            self?.transactionLists = transactionLists
//            self?.transactionLists = transactionLists.filter({ $0.type != TransactionIncomeType.UpdateBalance.rawValue })
            
            DispatchQueue.main.async {
                let summary = getTransactionSummaryFromList(transactionLists: transactionLists)
                self?.totalIncome = summary.totalIncome
                self?.totalExpense = summary.totalExpense
                self?.totalProfit = summary.totalIncome - summary.totalExpense
            }
        }
        
        transactionService
            .getTransactionList(startDate: startDate, endDate: endDate)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    func deleteTransaction(idToDelete: String) {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.deleteResult.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (Bool) -> Void = { [weak self] status in
//            self?.deleteResult.send(.finish)
        }
        
        let transactionReq = TransactionCRUDRequest(
            _id: idToDelete,
            description: "",
            date: "",
            category: -1,
            type: -1,
            amount: -1,
            discount: -1
        )
        
        transactionService
            .deleteTransaction(transactionReq: transactionReq)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
