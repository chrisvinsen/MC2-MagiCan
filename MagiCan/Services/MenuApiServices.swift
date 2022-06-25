//
//  MenuApiServices.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 24/06/22.
//

import Foundation
import Combine

protocol MenuServiceProtocol {
    func getMenuList() -> AnyPublisher<[Menu], Error>
    func addMenu(menuReq: MenuCRUDRequest) -> AnyPublisher<Menu, Error>
    func updateMenu(menuReq: MenuCRUDRequest) -> AnyPublisher<Menu, Error>
    func deleteMenu(menuReq: MenuCRUDRequest) -> AnyPublisher<Bool, Error>
    
    func getMenuImage(menuImageReq: MenuImagesCRUDRequestResponse) -> AnyPublisher<MenuImage, Error>
    func addMenuImage(menuImageReq: MenuImagesCRUDRequestResponse) -> AnyPublisher<MenuImage, Error>
}

final class MenuService: MenuServiceProtocol {
    //MARK: - Get Menu List --> /menus
    func getMenuList() -> AnyPublisher<[Menu], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Menu], Error>
        return Future<[Menu], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetMenuList() else {
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
                    let menuLists = try JSONDecoder().decode([Menu].self, from: data)
                    promise(.success(menuLists))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForGetMenuList() -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Menu.Lists.rawValue
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Add Menu --> /menus/add
    func addMenu(menuReq: MenuCRUDRequest) -> AnyPublisher<Menu, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = {
            dataTask?.cancel()
            
        }
        
        // promise type is Result<Menu, Error>
        return Future<Menu, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForAddMenu(menuReq: menuReq) else {
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
                
//                let jsonString = String(data: data, encoding: .utf8)!
//                print("RESP: \(jsonString)")
                
                do {
                    let menuCreated = try JSONDecoder().decode(Menu.self, from: data)
                    promise(.success(menuCreated))
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
    
    private func getUrlForAddMenu(menuReq: MenuCRUDRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Menu.Add.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(menuReq)
//        let jsonString = String(data: jsonData!, encoding: .utf8)!
//        print("REQ: \(jsonString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Update Menu --> /menus/update
    func updateMenu(menuReq: MenuCRUDRequest) -> AnyPublisher<Menu, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<Menu, Error>
        return Future<Menu, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForUpdateMenu(menuReq: menuReq) else {
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
                print("JSON: \(jsonString)")
                
                do {
                    let menuUpdated = try JSONDecoder().decode(Menu.self, from: data)
                    promise(.success(menuUpdated))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForUpdateMenu(menuReq: MenuCRUDRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Menu.Update.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(menuReq)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Delete Menu --> /menus/delete
    func deleteMenu(menuReq: MenuCRUDRequest) -> AnyPublisher<Bool, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<Bool, Error>
        return Future<Bool, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForDeleteMenu(menuReq: menuReq) else {
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
                print("RESP: \(jsonString)")
                
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
    
    private func getUrlForDeleteMenu(menuReq: MenuCRUDRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Menu.Delete.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(menuReq)
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        print("REQ: \(jsonString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    
    
    //MARK: - Get Menu Images --> /menus/images
    func getMenuImage(menuImageReq: MenuImagesCRUDRequestResponse) -> AnyPublisher<MenuImage, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Menu], Error>
        return Future<MenuImage, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForGetMenuImage(menuImageReq: menuImageReq) else {
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
                print("RESP: \(jsonString)")
                
                do {
                    let menuImage = try JSONDecoder().decode(MenuImage.self, from: data)
                    promise(.success(menuImage))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForGetMenuImage(menuImageReq: MenuImagesCRUDRequestResponse) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Menu.Image.Get.rawValue
        components.queryItems = [
            URLQueryItem(name: "menu_id", value: menuImageReq.menu_id)
        ]
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Add Menu Image --> /menus/images/add
    func addMenuImage(menuImageReq: MenuImagesCRUDRequestResponse) -> AnyPublisher<MenuImage, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = {
//            dataTask?.cancel()
            
        }
        
        // promise type is Result<Menu, Error>
        return Future<MenuImage, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForAddMenuImage(menuImageReq: menuImageReq) else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        print(error)
                        print(error.localizedDescription)
                        promise(.failure(error))
                    }
                    return
                }
                
                let jsonString = String(data: data, encoding: .utf8)!
                print("RESP: \(jsonString)")
                
                do {
                    let menuImageCreated = try JSONDecoder().decode(MenuImage.self, from: data)
                    promise(.success(menuImageCreated))
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
    
    private func getUrlForAddMenuImage(menuImageReq: MenuImagesCRUDRequestResponse) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Menu.Image.Add.rawValue
        
        guard let url = components.url else { return nil }
        let dummyMenuImageReq = MenuImagesCRUDRequestResponse(_id: "", menu_id: "27b5d6d2-6c4c-4d82-9290-d393d11d6d5c", image_url: menuImageReq.image_url)
        let jsonData = try? JSONEncoder().encode(dummyMenuImageReq)
//        let jsonData = try? JSONEncoder().encode(menuImageReq)
//        let jsonString = String(data: jsonData!, encoding: .utf8)!
//        print("REQ: \(jsonString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
}

