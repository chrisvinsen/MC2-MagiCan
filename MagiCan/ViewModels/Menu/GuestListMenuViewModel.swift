//
//  GuestListMenuViewModel.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import Combine

final class GuestListMenuViewModel {
    @Published var menuLists: [Menu] = [
        Menu(_id: "", name: "satu", description: "descs", imageUrl: "", price: 1111, isLoadingImage: false),
        Menu(_id: "", name: "dua", description: "descs", imageUrl: "", price: 222, isLoadingImage: false),
        Menu(_id: "", name: "tiga", description: "descs", imageUrl: "", price: 33, isLoadingImage: false),
    ]
    
    var result = PassthroughSubject<Void, Error>()
    
    private let menuService: MenuServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(menuService: MenuServiceProtocol = MenuService()) {
        self.menuService = menuService
    }
}
