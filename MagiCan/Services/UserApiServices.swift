//
//  UserApiServices.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    func checkUsernameExists(username: String) -> AnyPublisher<Bool, Error>
    func checkUsernameValidity(username: String) -> AnyPublisher<Bool, Error>
    func login(userLoginRequest: UserLoginRequest) -> AnyPublisher<UserSession, Error>
    func register(userRegisterRequest: UserRegisterRequest) -> AnyPublisher<UserSession, Error>
    func logout() -> AnyPublisher<User, Error>
    func validateToken(token: String) -> AnyPublisher<Bool, Error>
    func revalidateStoredTokenSynchronously()
    func getUserDetails() -> AnyPublisher<User, Error>
    func updateData(req: UserUpdateDataRequest) -> AnyPublisher<User, Error>
    func validatePIN(req: UserValidatePINRequest) -> AnyPublisher<Bool, Error>
    func changePIN(req: UserChangePINRequest) -> AnyPublisher<User, Error>
}

final class UserService: UserServiceProtocol {
    
    //MARK: - Check Username Exists --> /auth/check-username-exists
    func checkUsernameExists(username: String) -> AnyPublisher<Bool, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<Bool, Error>
        return Future<Bool, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForCheckUsernameExists(username: username) else {
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
                    let usernameExists = try JSONDecoder().decode(Bool.self, from: data)
                    promise(.success(usernameExists))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForCheckUsernameExists(username: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Auth.CheckUsernameExists.rawValue
        components.queryItems = [
            URLQueryItem(name: "username", value: username)
        ]
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    //MARK: - Check Username Validity --> /auth/check-username-validity
    func checkUsernameValidity(username: String) -> AnyPublisher<Bool, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<Bool, Error>
        return Future<Bool, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForCheckUsernameValidity(username: username) else {
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
                    let usernameValid = try JSONDecoder().decode(Bool.self, from: data)
                    promise(.success(usernameValid))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForCheckUsernameValidity(username: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Auth.CheckUsernameValidity.rawValue
        components.queryItems = [
            URLQueryItem(name: "username", value: username)
        ]
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    //MARK: - Login --> /auth/login
    func login(userLoginRequest: UserLoginRequest) -> AnyPublisher<UserSession, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<UserSession, Error>
        return Future<UserSession, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForLogin(userLoginRequest: userLoginRequest) else {
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
                    let userSession = try JSONDecoder().decode(UserSession.self, from: data)
                    promise(.success(userSession))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForLogin(userLoginRequest: UserLoginRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Auth.Login.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(userLoginRequest)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    //MARK: - Login --> /auth/signup
    func register(userRegisterRequest: UserRegisterRequest) -> AnyPublisher<UserSession, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<UserSession, Error>
        return Future<UserSession, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForRegister(userRegisterRequest: userRegisterRequest) else {
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
                    let userSession = try JSONDecoder().decode(UserSession.self, from: data)
                    promise(.success(userSession))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForRegister(userRegisterRequest: UserRegisterRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Auth.Register.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(userRegisterRequest)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    //MARK: - Logout --> /auth/logout
    func logout() -> AnyPublisher<User, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<User, Error>
        return Future<User, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForLogout() else {
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
                    let userSession = try JSONDecoder().decode(User.self, from: data)
                    promise(.success(userSession))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForLogout() -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Auth.Logout.rawValue
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Validate Token --> /auth/validate-token
    func validateToken(token: String) -> AnyPublisher<Bool, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<Bool, Error>
        return Future<Bool, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForValidateToken(token: token) else {
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
                    let tokenStatus = try JSONDecoder().decode(Bool.self, from: data)
                    promise(.success(tokenStatus))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForValidateToken(token: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.Auth.ValidateToken.rawValue
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(token, forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Revalidate Stored Token in User Defaults
    func revalidateStoredTokenSynchronously() {
        
        var dataTask: URLSessionDataTask?
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        
        let sessionToken = getUserTokenFromUserDefaults()
        
        guard let urlRequest = getUrlForValidateToken(token: sessionToken) else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            do {
                let tokenStatus = try JSONDecoder().decode(Bool.self, from: data)
                if !tokenStatus {
                    setUsernameFromUserDefaults(newUsername: "")
                    setUserTokenFromUserDefaults(newToken: "")
                    setTokenExpirationFromUserDefaults(expiration: "")
                }
            } catch {
                print(error.localizedDescription)
            }
            
            semaphore.signal()
        }
        
        dataTask?.resume()
        semaphore.wait()
    }
    
    //MARK: - Get User Details
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
                } catch {
                    promise(.failure(ServiceError.decode))
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
    
    //MARK: - Update Data
    func updateData(req: UserUpdateDataRequest) -> AnyPublisher<User, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<User, Error>
        return Future<User, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForUpdateData(req: req) else {
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
                    let userSession = try JSONDecoder().decode(User.self, from: data)
                    promise(.success(userSession))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForUpdateData(req: UserUpdateDataRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.User.UpdateData.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(req)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Validate PIN
    func validatePIN(req: UserValidatePINRequest) -> AnyPublisher<Bool, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<Bool, Error>
        return Future<Bool, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForValidatePIN(req: req) else {
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
                    let status = try JSONDecoder().decode(Bool.self, from: data)
                    promise(.success(status))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForValidatePIN(req: UserValidatePINRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.User.ValidatePIN.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(req)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
    
    //MARK: - Change PIN
    func changePIN(req: UserChangePINRequest) -> AnyPublisher<User, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<User, Error>
        return Future<User, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlForChangePIN(req: req) else {
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
                    let userSession = try JSONDecoder().decode(User.self, from: data)
                    promise(.success(userSession))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlForChangePIN(req: UserChangePINRequest) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIComponentScheme
        components.host = APIComponentHost
        components.path = Endpoint.User.ChangePIN.rawValue
        
        guard let url = components.url else { return nil }
        let jsonData = try? JSONEncoder().encode(req)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = APIDefaultTimeOut
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(getUserTokenFromUserDefaults(), forHTTPHeaderField: "token")
        
        return urlRequest
    }
}
