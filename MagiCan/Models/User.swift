//
//  User.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation


//MARK: - User
struct User: Equatable, Hashable, Decodable {
    var name, username: String
    var currentBalance: Int64
}

extension User {
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case currentBalance = "current_balance"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        currentBalance = try container.decode(Int64.self, forKey: .currentBalance)
    }
}

//MARK: - User Session
struct UserSession: Equatable, Hashable, Decodable {
//    let expiration: Date
    let token, username: String
}


//MARK: - Request for API User Login
struct UserLoginRequest: Equatable, Hashable, Encodable, Decodable {
    var username, pin: String
}

//MARK: - Request for API User Register
struct UserRegisterRequest: Equatable, Hashable, Encodable, Decodable {
    var name, username, pin: String
}

//MARK: - Request for API User Register
struct UserUpdateBalanceRequest: Equatable, Hashable, Encodable, Decodable {
    var updated_balance: Int64
    var is_create_transaction: Bool
}

struct UserUpdateDataRequest: Equatable, Hashable, Encodable, Decodable {
    var name: String
}

struct UserValidatePINRequest: Equatable, Hashable, Encodable, Decodable {
    var pin: String
}

struct UserChangePINRequest: Equatable, Hashable, Encodable, Decodable {
    var old_pin, new_pin: String
}
