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
    func getTransactionList(category: String) {
        
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
//                print("CALCULATE SUMMARY")
                let summary = getTransactionSummaryFromList(transactionLists: transactionLists)
                self?.totalIncome = summary.totalIncome
                self?.totalExpense = summary.totalExpense
//                print(summary)
            }
        }
        
        statisticsService
            .getTransactionList(category: category)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
