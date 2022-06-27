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
        case currentBalance
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
