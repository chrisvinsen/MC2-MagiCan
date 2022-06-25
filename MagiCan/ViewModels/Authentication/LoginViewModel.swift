//
//  LoginViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation
import Combine

enum LoginViewModelError: Error, Equatable {
    case playersFetch
}

enum LoginViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(LoginViewModelError)
}

final class LoginViewModel {
    @Published var username: String = ""
    @Published var pin: String = "" {
        didSet {
            
            if pin.count == 6 {
                login()
            }
        }
    }
    @Published var isUsernameExists = false
    @Published var isLoginSuccess = false
    @Published private(set) var state: LoginViewModelState = .loading
    
    let validationResult = PassthroughSubject<Void, Error>()
    let loginResult = PassthroughSubject<Void, Error>()
    
    private let userService: UserServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    //MARK: - Check Username
    func checkUsernameExists() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.validationResult.send(completion: .failure(error))
            case .finished:
                self?.validationResult.send(())
            }
        }
        
        let valueHandler: (Bool) -> Void = { [weak self] isUsernameExists in
            self?.isUsernameExists = isUsernameExists
        }
        
        userService
            .checkUsernameExists(username: self.username)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - Login
    func login() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.isLoginSuccess = false
                self?.loginResult.send(completion: .failure(error))
            case .finished:
                self?.loginResult.send(())
            }
        }
        
        let valueHandler: (UserSession) -> Void = { [weak self] userSession in
            setUsernameFromUserDefaults(newUsername: userSession.username)
            setUserTokenFromUserDefaults(newToken: userSession.token)
            
            self?.isLoginSuccess = true
        }
        
        let userLoginRequest = UserLoginRequest(username: self.username.lowercased(), pin: self.pin)
        
        userService
            .login(userLoginRequest: userLoginRequest)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
