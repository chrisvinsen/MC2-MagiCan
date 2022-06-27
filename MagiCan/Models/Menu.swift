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
    
    var isLoadingImage: Bool = false
    
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
    var _id, name, description: String
    var price: Int64
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
