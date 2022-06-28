//
//  StatisticsApiServices.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 27/06/22.
//

import Foundation
import Combine

protocol StaticticsServiceProtocol {
    func getKasAmount() -> AnyPublisher<User, Error>
    func getTransactionList(category: String) -> AnyPublisher<[Transaction], Error>
}

final class StatisticsService: StaticticsServiceProtocol {
    func getKasAmount() -> AnyPublisher<User, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Transaction], Error>
        return Future<User, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetKasAmount() else {
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
                    let user = try JSONDecoder().decode(User.self, from: data)
                    promise(.success(user))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForGetKasAmount() -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.User.Get.rawValue
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    func getTransactionList(category: String) -> AnyPublisher<[Transaction], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Transaction], Error>
        return Future<[Transaction], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetTransactionList(category: category) else {
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
    
    private func getUrlForGetTransactionList(category: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Transaction.Lists.rawValue
        components.queryItems = [
            URLQueryItem(name: "category", value: category)
        ]
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
}
