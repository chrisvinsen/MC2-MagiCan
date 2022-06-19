//
//  UserSession.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import Foundation

struct UserSession: Equatable, Hashable, Decodable {
//    let expiration: Date
    let token, username: String
}
