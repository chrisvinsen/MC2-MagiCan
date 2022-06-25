//
//  EditMenuViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import Combine

final class EditMenuViewModel {
    @Published var _id: String = ""
    
    @Published var name: String = ""
    @Published var priceString: String = ""
    @Published var description: String = ""
    @Published var base64Image: String = ""
    
    let result = PassthroughSubject<Menu, Error>()
    
    private let menuService: MenuServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(menuService: MenuServiceProtocol = MenuService()) {
        self.menuService = menuService
    }
    
    //MARK: - Add Menu
    func updateMenu() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                print("SEND FINISHED")
                self?.result.send(completion: .finished)
            }
        }
        
        let valueHandler: (Menu) -> Void = { [weak self] newMenu in
            self?.result.send(newMenu)
        }
        
        let menuRequest = MenuCRUDRequest(
            _id: self._id,
            name: self.name,
            description: self.description,
            price: Int64(self.priceString) ?? 0
        )
        
        menuService
            .updateMenu(menuReq: menuRequest)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}

