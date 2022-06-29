//
//  ChangePINViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import Foundation
import Combine

class ChangePINViewModel {
    @Published var oldPIN: String = "" {
        didSet {
            if oldPIN.count == 6 {
                validatePIN()
            }
        }
    }
    @Published var newPIN: String = "" {
        didSet {
            
        }
    }
    
    let validationResult = PassthroughSubject<Bool, Error>()
    let changePINResult = PassthroughSubject<Void, Error>()
    let menuResult = PassthroughSubject<Void, Error>()
    
    private let userService: UserServiceProtocol

    private var bindings = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    //MARK: - Validate PIN
    func validatePIN() {

        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.validationResult.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (Bool) -> Void = { [weak self] isUsernameValid in
            self?.validationResult.send(isUsernameValid)
        }
        
        print("VALIDATE TOKEN \(self.oldPIN)")
        
        userService
            .validatePIN(req: UserValidatePINRequest(pin: self.oldPIN))
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - Change PIN
    func changePIN() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.changePINResult.send(completion: .failure(error))
            case .finished:
                self?.changePINResult.send(())
            }
        }
        
        let valueHandler: (User) -> Void = { [weak self] user in

        }
        
        userService
            .changePIN(req: UserChangePINRequest(old_pin: self.oldPIN, new_pin: self.newPIN))
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }

}
