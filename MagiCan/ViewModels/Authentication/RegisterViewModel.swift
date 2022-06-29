//
//  RegisterViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation
import Combine

enum RegisterViewModelError: Error, Equatable {
    case playersFetch
}

enum RegisterViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(LoginViewModelError)
}

final class RegisterViewModel {
    var name: String = ""
    @Published var username: String = ""
    @Published var pin: String = ""
    @Published var pinConfirm: String = "" {
        didSet {
            if pinConfirm.count == 6 {
                if pin == pinConfirm {
                    isPinMatch = true
                } else {
                    isPinMatch = false
                }
            }
        }
    }
    @Published var guestMenu = [Menu]()

    @Published var isUsernameValid = false
    @Published var isPinMatch = false
    @Published var isRegisterSuccess = false
    @Published private(set) var state: RegisterViewModelState = .loading
    
    let validationResult = PassthroughSubject<Void, Error>()
    let registerResult = PassthroughSubject<Void, Error>()
    let menuResult = PassthroughSubject<Void, Error>()
    
    private let userService: UserServiceProtocol
    private let menuService: MenuServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol = UserService(), menuService: MenuServiceProtocol = MenuService()) {
        self.userService = userService
        self.menuService = menuService
    }
    
    //MARK: - Check Username Validity
    func checkUsernameValidity() {

        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.isUsernameValid = false
                self?.validationResult.send(completion: .failure(error))
            case .finished:
                self?.validationResult.send(())
            }
        }
        
        let valueHandler: (Bool) -> Void = { [weak self] isUsernameValid in
            self?.isUsernameValid = isUsernameValid
        }
        
        userService
            .checkUsernameValidity(username: self.username)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - Register User
    func register() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.isRegisterSuccess = false
                self?.registerResult.send(completion: .failure(error))
            case .finished:
                self?.registerResult.send(())
            }
        }
        
        let valueHandler: (UserSession) -> Void = { [weak self] userSession in
            setUsernameFromUserDefaults(newUsername: userSession.username)
            setUserTokenFromUserDefaults(newToken: userSession.token)
            
            self?.isRegisterSuccess = true
        }
        
        let userRegisterRequest = UserRegisterRequest(
            name: self.name,
            username: self.username.lowercased(),
            pin: self.pin
        )
        
        userService
            .register(userRegisterRequest: userRegisterRequest)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - Post Menu for Guest
    func addMenu() {
        
        for menu in guestMenu.reversed() {
            
            let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.menuResult.send(completion: .failure(error))
                case .finished:
                    self?.menuResult.send(completion: .finished)
                }
            }
            
            let valueHandler: (Menu) -> Void = { [weak self] newMenu in
                print(newMenu)
            }
            
            let menuRequest = MenuCRUDRequest(
                _id: "",
                name: menu.name,
                description: menu.description,
                image_url: menu.imageUrl ?? "",
                price: menu.price
            )
            
            menuService
                .addMenuWithImage(menuReq: menuRequest)
                .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
                .store(in: &bindings)
        }
    }
}
