//
//  Menu.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 24/06/22.
//

import Foundation


//MARK: - Menu
struct Menu: Equatable, Hashable, Encodable, Decodable {
    var _id, name, description: String
    var imageUrl: String?
    var price: Int64
    
    var isLoadingImage: Bool = false // Used to loading image async
    var isMenuChosen: Bool = false // Used to differentiate chosen menu
    
    enum CodingKeys: String, CodingKey {
        case _id
        case name
        case description
        case imageUrl = "image_url"
        case price
    }
}

//MARK: - Request for API Menu CRUD
struct MenuCRUDRequest: Equatable, Hashable, Encodable, Decodable {
    var _id, name, description, image_url: String
    var price: Int64
}

//MARK: - Menu Chosen
struct MenuChosen: Equatable, Hashable, Encodable, Decodable {
    var trxId, name, description, imageUrl, menuId: String
    var price: Int64
    var qty: Int
    
    enum CodingKeys: String, CodingKey {
        case trxId = "trx_id"
        case name
        case description
        case imageUrl = "image_url"
        case menuId = "menu_id"
        case price
        case qty
    }
}

//MARK: - Transaction Menu
struct TransactionMenu: Equatable, Hashable, Encodable, Decodable {
    var trxId, name, description, menuId: String
    var price: Int64
    var qty: Int
    
    enum CodingKeys: String, CodingKey {
        case trxId = "trx_id"
        case name
        case description
        case menuId = "menu_id"
        case price
        case qty
    }
}

//MARK: - Menu Andalan
struct MenuAndalan: Equatable, Hashable, Encodable, Decodable {
    var name, imageUrl, menuId: String
    var qty: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case menuId = "menu_id"
        case qty
    }
}

//MARK: - Menu Image
struct MenuImage: Equatable, Hashable, Encodable, Decodable {
    var _id, menu_id: String
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case _id
        case menu_id
        case imageUrl = "image_url"
    }
}

//MARK: - Request and Response for API Menu Images
struct MenuImagesCRUDRequestResponse: Equatable, Hashable, Encodable, Decodable {
    var _id, menu_id, image_url: String
}
