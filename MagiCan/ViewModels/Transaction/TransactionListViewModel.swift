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
    
    var result = PassthroughSubject<Void, Error>()
    
    private let transactionService: TransactionServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(transactionService: TransactionServiceProtocol = TransactionService()) {
        self.transactionService = transactionService
    }
    
    //MARK: - Get Transaction List
    func getTransactionList() {
        
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
            
            DispatchQueue.main.async {
                print("CALCULATE SUMMARY")
                let summary = getTransactionSummaryFromList(transactionLists: transactionLists)
                self?.totalIncome = summary.totalIncome
                self?.totalExpense = summary.totalExpense
                print(summary)
            }
        }
        
        transactionService
            .getTransactionList()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
