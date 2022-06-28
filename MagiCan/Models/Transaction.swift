//
//  Transaction.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation

//MARK: - Transaction
struct Transaction: Equatable, Hashable, Encodable, Decodable {
    var _id: String
    var category: Int
    var type: Int
    var amount: Int64
    var discount: Int64
    var description: String
    var dateString: String
    var imageUrl: String
    var iterator: Int
    
    enum CodingKeys: String, CodingKey {
        case _id
        case category
        case type
        case amount
        case discount
        case description
        case dateString = "date"
        case imageUrl = "image_url"
        case iterator
    }
}

//MARK: - Request for API Transaction CRUD
struct TransactionCRUDRequest: Equatable, Hashable, Encodable, Decodable {
    var _id, description, date: String
    var category, type: Int
    var amount, discount: Int64
}

