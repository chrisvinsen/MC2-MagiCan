//
//  Services.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import Foundation

let APIBaseUrl = "https://magican.cvinsen.me"
let APIComponentScheme = "https"
let APIComponentHost = "magican.cvinsen.me"
let APIDefaultTimeOut = 10.0

enum Endpoint {
    enum Auth: String {
        case CheckUsernameExists = "/auth/check-username-exists"
        case CheckUsernameValidity = "/auth/check-username-validity"
        case ValidateToken = "/auth/validate-token"
        case Login = "/auth/login"
        case Register = "/auth/signup"
        case Logout = "/auth/logout"
    }
    enum Menu: String {
        case Lists = "/menus"
        case Add = "/menus/add"
        case AddWithImage = "/menus/add-with-image"
        case Update = "/menus/update"
        case Delete = "/menus/delete"
        
        enum Image: String {
            case Get = "/menus/images"
            case AddUpdate = "/menus/images/add-update"
        }
    }
    enum Transaction: String {
        case Lists = "/transactions"
        case Add = "/transactions/add"
        case Update = "/transactions/update"
        case Delete = "/transactions/delete"
        
        enum Menu: String {
            case Lists = "/transactions/menus"
        }
    }
    enum User: String {
        case Get = "/user"
        case UpdateBalance = "/user/update-balance"
        case UpdateData = "/user/update-data"
        case ValidatePIN = "/user/validate-pin"
        case ChangePIN = "/user/change-pin"
    }
}


enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}
