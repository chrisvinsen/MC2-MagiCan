//
//  MenuCellViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import Combine


final class MenuCellViewModel {
    @Published var menuImage: MenuImage!
    
    var cellResult = CurrentValueSubject<MenuImage, Error>(MenuImage(_id: "", menu_id: ""))
    
    private let menuService: MenuServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(menuService: MenuServiceProtocol = MenuService()) {
        self.menuService = menuService
    }
    
    //MARK: - Get Menu Image
    func getMenuImage(menu_id: String) {
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.cellResult.send(completion: .failure(error))
            case .finished:
                return
            }
        }
        
        let valueHandler: (MenuImage) -> Void = { [weak self] menuImage in
            self?.cellResult.send(menuImage)
        }
        
        let req = MenuImagesCRUDRequestResponse(_id: "", menu_id: menu_id, image_url: "")
        print(req)
        
        menuService
            .getMenuImage(menuImageReq: req)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
