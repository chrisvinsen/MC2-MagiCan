//
//  TransactionApiServices.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation
import Combine

protocol TransactionServiceProtocol {
    func getTransactionList() -> AnyPublisher<[Transaction], Error>
    func addTransaction(transactionReq: TranasctionCRUDRequest) -> AnyPublisher<Transaction, Error>
}

final class TransactionService: TransactionServiceProtocol {
    
    //MARK: - Get Transaction List --> /transactions
    func getTransactionList() -> AnyPublisher<[Transaction], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Transaction], Error>
        return Future<[Transaction], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetTransactionList() else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                
                let jsonString = String(data: data, encoding: .utf8)!
                print("DATA : \(jsonString)")
                
                do {
                    let lists = try JSONDecoder().decode([Transaction].self, from: data)
                    promise(.success(lists))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForGetTransactionList() -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Transaction.Lists.rawValue
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Add Transaction --> /transactions/add
    func addTransaction(transactionReq: TranasctionCRUDRequest) -> AnyPublisher<Transaction, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = {
            dataTask?.cancel()
            
        }
        
        // promise type is Result<Transaction, Error>
        return Future<Transaction, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForAddTransaction(transactionReq: transactionReq) else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                
                do {
                    let transactionCreated = try JSONDecoder().decode(Transaction.self, from: data)
                    promise(.success(transactionCreated))
                } catch {
                    print(error)
                    print(error.localizedDescription)
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForAddTransaction(transactionReq: TranasctionCRUDRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Transaction.Add.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(transactionReq)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
}
