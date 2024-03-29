//
//  ListRiwayatTransaksiViewModel.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 27/06/22.
//

import Foundation
import Combine

final class ListRiwayatTransaksiViewModel {
    @Published var transactionLists: [Transaction] = []
    @Published var totalIncome: Int64 = 0
    @Published var totalExpense: Int64 = 0
    
    var result = PassthroughSubject<Void, Error>()
    
    private let statisticsService: StaticticsServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(statisticsService: StaticticsServiceProtocol = StatisticsService()) {
        self.statisticsService = statisticsService
    }
    
    //MARK: - Get Transaction List
    func getTransactionList(category: String, startDate: String, endDate: String) {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
                print("error 123")
            case .finished:
                self?.result.send(())
                print("finished 456")
            }
        }
        
        let valueHandler: ([Transaction]) -> Void = { [weak self] transactionLists in
            self?.transactionLists = transactionLists
            // filter out transactions with type UpdateBalance
//            self?.transactionLists = transactionLists.filter({ $0.type != TransactionIncomeType.UpdateBalance.rawValue })
            
            DispatchQueue.main.async {
                let summary = getTransactionSummaryFromList(transactionLists: transactionLists)
                self?.totalIncome = summary.totalIncome
                self?.totalExpense = summary.totalExpense
            }
        }
        
        statisticsService
            .getTransactionList(category: category, startDate: startDate, endDate: endDate)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
