//
//  KasAmountViewModel.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 28/06/22.
//

import Foundation
import Combine

final class KasAmountViewModel {
    @Published var userDetail: User?
    @Published var kasAmount: Int64 = 2000000
    
    var result = PassthroughSubject<Void, Error>()
    
    private let statisticsService: StaticticsServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(statisticsService: StaticticsServiceProtocol = StatisticsService()) {
        self.statisticsService = statisticsService
    }
    
    func getUserDetail() {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                self?.result.send(())
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
            self?.userDetail = userDetail
            
            DispatchQueue.main.async {
                self?.kasAmount = userDetail.currentBalance
            }
        }
        
        statisticsService
            .getKasAmount()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
