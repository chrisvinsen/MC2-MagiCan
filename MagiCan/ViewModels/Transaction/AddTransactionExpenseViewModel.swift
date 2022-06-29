//
//  AddTransactionExpenseViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation
import Combine

final class AddTransactionExpenseViewModel {
    @Published var transactionDate: Date = Date()
    @Published var transactionType: Int = -1
    @Published var amountString: String = ""
    @Published var description: String = ""
    
    let result = PassthroughSubject<Transaction, Error>()
    
    private let transactionService: TransactionServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(transactionService: TransactionServiceProtocol = TransactionService()) {
        
        self.transactionService = transactionService
    }
    
    //MARK: - Add Transaction
    func addTransaction() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                self?.result.send(completion: .finished)
            }
        }
        
        let valueHandler: (Transaction) -> Void = { [weak self] newTrx in
            self?.result.send(newTrx)
        }
        
        let trxRequest = TransactionCRUDRequest(
            _id: "",
            description: self.description,
            date: dateTimeToString(self.transactionDate),
            category: TransactionCategory.Expense.rawValue,
            type: self.transactionType,
            amount: Int64(amountString) ?? 0,
            discount: 0
        )
        
        transactionService
            .addTransaction(transactionReq: trxRequest)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
