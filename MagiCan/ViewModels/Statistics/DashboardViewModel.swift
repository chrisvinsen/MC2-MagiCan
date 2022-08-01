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
    @Published var kasAmount: Int64 = 0
    @Published var kasAmountEdit: String = "0"
//    @Published var kasCreateTransaction: Bool = true
    @Published var initialCashSet: Bool = false
    
    @Published var transactionLists: [Transaction] = []
    @Published var totalIncome: Int64 = 0
    @Published var totalExpense: Int64 = 0
    
    let result = PassthroughSubject<User, Error>()
    
    var resultUserDetail = PassthroughSubject<User, Error>()
    var resultTransactions = PassthroughSubject<Void, Error>()
    var resultTopMenu = PassthroughSubject<[MenuAndalan], Error>()
    var resultTopMenuImage = PassthroughSubject<MenuImage, Error>()
    
    private let statisticsService: StaticticsServiceProtocol
    private let transactionService: TransactionServiceProtocol
    private let menuService: MenuServiceProtocol
    
    private var bindingsUserDetails = Set<AnyCancellable>()
    private var bindingsTransactions = Set<AnyCancellable>()
    
    init(statisticsService: StaticticsServiceProtocol = StatisticsService(), transactionService: TransactionServiceProtocol = TransactionService(), menuService: MenuServiceProtocol = MenuService()) {
        self.statisticsService = statisticsService
        self.transactionService = transactionService
        self.menuService = menuService
    }
    
    func getUserDetail() {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.resultUserDetail.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
            DispatchQueue.main.async {
                self?.kasAmount = userDetail.currentBalance
                self?.initialCashSet = userDetail.isInitialCashSet
                self?.resultUserDetail.send(userDetail)
            }
        }
        
        statisticsService
            .getUserDetails()
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
                return
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
//            self?.result.send(userDetail)
            self?.kasAmount = userDetail.currentBalance
        }
        
//        let userReq = UserUpdateBalanceRequest(updated_balance: Int64(kasAmountEdit) ?? 0, is_create_transaction: kasCreateTransaction)
        let userReq = UserUpdateBalanceRequest(updated_balance: Int64(kasAmountEdit) ?? 0)
        
        statisticsService
            .editKasAmount(userReq: userReq)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindingsUserDetails)
    }
    
    //MARK: - Get Transaction List
    func getTransactionList(startDate: String, endDate: String) {
        
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
                let summary = getTransactionSummaryFromList(transactionLists: transactionLists)
                self?.totalIncome = summary.totalIncome
                self?.totalExpense = summary.totalExpense
            }
        }
        
        transactionService
            .getTransactionList(startDate: startDate, endDate: endDate)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindingsTransactions)
    }
    
    //MARK: - Get Menu Andalan
    func getTopThreeMenu() {
        
        print("GET TOP THREE MENU")
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.resultTopMenu.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: ([TransactionMenu]) -> Void = { [weak self] datas in
            
            var transactionMenu = [MenuAndalan]()
            
            for data in datas {
                if let idx = transactionMenu.firstIndex(where: { $0.menuId == data.menuId }) {
                    
                    transactionMenu[idx].qty += data.qty
                } else {
                    transactionMenu.append(MenuAndalan(name: data.name, imageUrl: "", menuId: data.menuId, qty: data.qty))
                }
                
            }
            
            self?.resultTopMenu.send(transactionMenu)
        }
        
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        
        transactionService
            .getTransactionMenus(startDate: dateTimeToString(startDate, "yyyy-MM-dd"), endDate: dateTimeToString(endDate, "yyyy-MM-dd"))
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindingsTransactions)
    }
    
    //MARK: - Get Menu Image
    func getMenuImage(menu_id: String) {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.resultTopMenuImage.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (MenuImage) -> Void = { [weak self] menuImage in
            self?.resultTopMenuImage.send(menuImage)
        }
        
        let req = MenuImagesCRUDRequestResponse(_id: "", menu_id: menu_id, image_url: "")
        print(req)
        
        menuService
            .getMenuImage(menuImageReq: req)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindingsTransactions)
    }
}
