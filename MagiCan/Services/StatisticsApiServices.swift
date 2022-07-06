//
//  StatisticsApiServices.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 27/06/22.
//

import Foundation
import Combine

protocol StaticticsServiceProtocol {
    func getUserDetails() -> AnyPublisher<User, Error>
    func editKasAmount(userReq: UserUpdateBalanceRequest) -> AnyPublisher<User, Error>
    func getTransactionList(category: String, startDate: String, endDate: String) -> AnyPublisher<[Transaction], Error>
}

final class StatisticsService: StaticticsServiceProtocol {
    
    func getUserDetails() -> AnyPublisher<User, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Transaction], Error>
        return Future<User, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetUserDetails() else {
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
                    let user = try JSONDecoder().decode(User.self, from: data)
                    promise(.success(user))
                    print("decode sukses", user)
                } catch {
                    promise(.failure(ServiceError.decode))
                    print("error saat decode")
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForGetUserDetails() -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.User.Get.rawValue
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    func editKasAmount(userReq: UserUpdateBalanceRequest) -> AnyPublisher<User, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Transaction], Error>
        return Future<User, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForEditKasAmount(userReq: userReq) else {
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
                    let userUpdated = try JSONDecoder().decode(User.self, from: data)
                    promise(.success(userUpdated))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForEditKasAmount(userReq: UserUpdateBalanceRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.User.UpdateBalance.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(userReq)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    func getTransactionList(category: String, startDate: String, endDate: String) -> AnyPublisher<[Transaction], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Transaction], Error>
        return Future<[Transaction], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetTransactionList(category: category, startDate: startDate, endDate: endDate) else {
                promise(.failure(ServiceError.urlRequest))
//                print("error 1")
                return
            }
            
//            print("halo 1")
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
//                    print("error 2")
                    return
                }
                
//                print("halo 2")
                
                do {
                    let lists = try JSONDecoder().decode([Transaction].self, from: data)
                    promise(.success(lists))
//                    print("ini list transaksi di service", lists)
                } catch {
                    promise(.failure(ServiceError.decode))
//                    print("fail list transaksi di service")
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForGetTransactionList(category: String, startDate: String, endDate: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Transaction.Lists.rawValue
        components.queryItems = [
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate)
        ]
        
//        print("di service start date:", startDate)
//        print("di service end date:", endDate)
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
}
