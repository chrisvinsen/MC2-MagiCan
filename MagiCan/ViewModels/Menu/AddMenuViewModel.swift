//
//  AddMenuViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import Combine

final class AddMenuViewModel {
    @Published var name: String = ""
    @Published var priceString: String = ""
    @Published var description: String = ""
    @Published var base64Image: String = ""
    
    let result = PassthroughSubject<Menu, Error>()
    let resultImage = PassthroughSubject<Void, Error>()
    
    private let menuService: MenuServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(menuService: MenuServiceProtocol = MenuService()) {
        self.menuService = menuService
    }
    
    //MARK: - Add Menu
    func addMenu() {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.result.send(completion: .failure(error))
            case .finished:
                self?.result.send(completion: .finished)
            }
        }
        
        let valueHandler: (Menu) -> Void = { [weak self] newMenu in
            self?.result.send(newMenu)
        }
        
        let menuRequest = MenuCRUDRequest(
            _id: "",
            name: self.name,
            description: self.description,
//            image_url: self.base64Image,
            price: Int64(self.priceString) ?? 0
        )
        
        menuService
            .addMenu(menuReq: menuRequest)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - Add Menu Image
    func addMenuImage(menuId: String) {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.resultImage.send(completion: .failure(error))
            case .finished:
                self?.resultImage.send(completion: .finished)
            }
        }
        
        let valueHandler: (MenuImage) -> Void = { [weak self] newMenu in
            print(newMenu)
        }
        
        let menuImageReq = MenuImagesCRUDRequestResponse(
            _id: "",
            menu_id: menuId,
            image_url: self.base64Image
        )
        
        menuService
            .addMenuImage(menuImageReq: menuImageReq)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
