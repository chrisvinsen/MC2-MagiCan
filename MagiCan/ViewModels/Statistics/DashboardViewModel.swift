//
//  KasAmountViewModel.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 28/06/22.
//

import Foundation
import Combine

final class DashboardViewModel {
//    @Published var userDetail: User?
    @Published var kasAmount: Int64 = 1
    @Published var kasAmountEdit: String = "2"
    
    @Published var transactionLists: [Transaction] = []
    @Published var totalIncome: Int64 = 0
    @Published var totalExpense: Int64 = 0
    
    let result = PassthroughSubject<User, Error>()
    
    var resultUserDetail = PassthroughSubject<Void, Error>()
    var resultTransactions = PassthroughSubject<Void, Error>()
    
    private let statisticsService: StaticticsServiceProtocol
    private let transactionService: TransactionServiceProtocol
    
    private var bindingsUserDetails = Set<AnyCancellable>()
    private var bindingsTransactions = Set<AnyCancellable>()
    
    init(statisticsService: StaticticsServiceProtocol = StatisticsService(), transactionService: TransactionServiceProtocol = TransactionService()) {
        self.statisticsService = statisticsService
        self.transactionService = transactionService
    }
    
    func getUserDetail() {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.resultUserDetail.send(completion: .failure(error))
                print(error)
            case .finished:
                self?.resultUserDetail.send(())
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
//            self?.userDetail = userDetail
            print("abc")
            DispatchQueue.main.async {
                print("ini userDetail", userDetail)
                self?.kasAmount = userDetail.currentBalance
            }
        }
        
        statisticsService
            .getKasAmount()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindingsUserDetails)
    }
    
    func saveKasAmount() {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.resultUserDetail.send(completion: .failure(error))
                print(error)
            case .finished:
                self?.resultUserDetail.send(())
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
            self?.result.send(userDetail)
        }
        
        let userReq = UserUpdateBalanceRequest(updated_balance: Int64(kasAmountEdit)!)
        
        statisticsService
            .editKasAmount(userReq: userReq)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindingsUserDetails)
    }
    
    //MARK: - Get Transaction List
    func getTransactionList() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.resultTransactions.send(completion: .failure(error))
            case .finished:
                self?.resultTransactions.send(())
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
        
        transactionService
            .getTransactionList()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindingsTransactions)
    }
}
