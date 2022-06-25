//
//  ListMenuViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 24/06/22.
//

import Foundation
import Combine

enum StateRequest {
    case empty, starting, procesing, finish
}
    

final class ListMenuViewModel {
    @Published var menuLists: [Menu] = []
    
    var result = PassthroughSubject<Void, Error>()
    var deleteResult = CurrentValueSubject<StateRequest, Error>(.empty)
    private let menuService: MenuServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(menuService: MenuServiceProtocol = MenuService()) {
        self.menuService = menuService
    }
    
    //MARK: - Get Menu List
    func getMenuList() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                self?.result.send(())
            }
        }
        
        let valueHandler: ([Menu]) -> Void = { [weak self] menuLists in
            self?.menuLists = menuLists
        }
        
        menuService
            .getMenuList()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    func deleteMenu(idToDelete: String) {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.deleteResult.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (Bool) -> Void = { [weak self] status in
            print("DELETE STATUE \(status)")
            self?.deleteResult.send(.finish)
        }
        
        let menuRequest = MenuCRUDRequest(
            _id: idToDelete,
            name: "",
            description: "",
//            image_url: "",
            price: 0
        )
        
        menuService
            .deleteMenu(menuReq: menuRequest)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
