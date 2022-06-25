//
//  Helper.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 24/06/22.
//

import Foundation


//MARK: - User Defaults
func getUsernameFromUserDefaults() -> String {
    return userDefaults.string(forKey: UserDefaultKeys.username.rawValue) ?? ""
}
func setUsernameFromUserDefaults(newUsername: String) {
    userDefaults.set(newUsername, forKey: UserDefaultKeys.username.rawValue)
}
func getUserTokenFromUserDefaults() -> String {
    return userDefaults.string(forKey: UserDefaultKeys.token.rawValue) ?? ""
}
func setUserTokenFromUserDefaults(newToken: String) {
    userDefaults.set(newToken, forKey: UserDefaultKeys.token.rawValue)
}
