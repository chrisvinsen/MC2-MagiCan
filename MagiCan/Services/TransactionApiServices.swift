//
//  TransactionApiServices.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation
import Combine

protocol TransactionServiceProtocol {
    func getTransactionList(startDate: String, endDate: String) -> AnyPublisher<[Transaction], Error>
    func addTransaction(transactionReq: TransactionCRUDRequest) -> AnyPublisher<Transaction, Error>
    func deleteTransaction(transactionReq: TransactionCRUDRequest) -> AnyPublisher<Bool, Error>
}

final class TransactionService: TransactionServiceProtocol {
    
    //MARK: - Get Transaction List --> /transactions
    func getTransactionList(startDate: String, endDate: String) -> AnyPublisher<[Transaction], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Transaction], Error>
        return Future<[Transaction], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetTransactionList(startDate: startDate, endDate: endDate) else {
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
    
    private func getUrlForGetTransactionList(startDate: String, endDate: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Transaction.Lists.rawValue
        components.queryItems = [
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate)
        ]
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Add Transaction --> /transactions/add
    func addTransaction(transactionReq: TransactionCRUDRequest) -> AnyPublisher<Transaction, Error> {
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
    
    private func getUrlForAddTransaction(transactionReq: TransactionCRUDRequest) -> URLRequest? {
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
    
    
    //MARK: - Delete Transaction --> /transactions/delete
    func deleteTransaction(transactionReq: TransactionCRUDRequest) -> AnyPublisher<Bool, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<Bool, Error>
        return Future<Bool, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForDeleteTransaction(transactionReq: transactionReq) else {
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
                    promise(.success(true))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForDeleteTransaction(transactionReq: TransactionCRUDRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Transaction.Delete.rawValue
        
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
