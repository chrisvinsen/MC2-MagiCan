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
    
    let result = PassthroughSubject<Void, Error>()
    
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
                self?.result.send(completion: .finished)
            }
        }
        
        let valueHandler: (Menu) -> Void = { [weak self] newMenu in
            print(newMenu)
        }
        
        print(self.priceString)
        print(Int64(self.priceString) ?? 0)
        
        let menuRequest = MenuCRUDRequest(
            _id: self._id,
            name: self.name,
            description: self.description,
//            image_url: self.base64Image,
            price: Int64(self.priceString) ?? 0
        )
        
        menuService
            .updateMenu(menuReq: menuRequest)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}

