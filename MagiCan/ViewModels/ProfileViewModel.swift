//
//  ProfileViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import Foundation
import Combine

final class ProfileViewModel {
    @Published var name: String = ""
    @Published var username: String = ""
    
    let result = PassthroughSubject<Void, Error>()
    
    private let userService: UserServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    //MARK: - Get User Details
    func getUserDetail() {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
            self?.name = userDetail.name
            self?.username = userDetail.username
        }
        
        userService
            .getUserDetails()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - Update Data
    func updateData(req: UserUpdateDataRequest) {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
            self?.name = userDetail.name
        }
        
        userService
            .updateData(req: req)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - Logout
    func logout() {
        setUsernameFromUserDefaults(newUsername: "")
        setUserTokenFromUserDefaults(newToken: "")
        setTokenExpirationFromUserDefaults(expiration: "")
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                self?.result.send(completion: .finished)
                return
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] userDetail in
            
        }
        
        userService
            .logout()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
