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
func getTokenExpirationFromUserDefaults() -> Date? {
    let dateString = userDefaults.string(forKey: UserDefaultKeys.token_expiration.rawValue) ?? ""
    
    print("GOT DATE STRING", dateString)
    
    if dateString != "" {
        return stringToDateTime(dateString, "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    return nil
}
func setTokenExpirationFromUserDefaults(expiration: String) {
    print("SET DATE STRING", expiration)
    userDefaults.set(expiration, forKey: UserDefaultKeys.token_expiration.rawValue)
}
func isTokenValid() -> Bool {
    guard let expirationDate = getTokenExpirationFromUserDefaults() else {
        setUsernameFromUserDefaults(newUsername: "")
        setUserTokenFromUserDefaults(newToken: "")
        setTokenExpirationFromUserDefaults(expiration: "")
        return false
    }
    
    if expirationDate >= Date.now {
        return true
    }
    
    setUsernameFromUserDefaults(newUsername: "")
    setUserTokenFromUserDefaults(newToken: "")
    setTokenExpirationFromUserDefaults(expiration: "")
    return false
}

func getTransactionSummaryFromList(transactionLists: [Transaction]) -> (totalIncome: Int64, totalExpense: Int64) {
    
    var totalIncome: Int64 = 0
    var totalExpense: Int64 = 0
    
    for transaction in transactionLists {
        switch transaction.category {
        case TransactionCategory.Income.rawValue:
            totalIncome += transaction.amount
        case TransactionCategory.Expense.rawValue:
            totalExpense += transaction.amount
        default: break
        }
    }
    
    return (totalIncome, totalExpense)
}


func dateTimeToString(_ dateTime: Date, _ dateFormat: String = "M/d/yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
     
    let result = dateFormatter.string(from: dateTime)
    
    return result
}

func stringToDateTime(_ dateTimeStr: String, _ dateFormat: String = "M/d/yyyy HH:mm:ss") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
     
    return dateFormatter.date(from: dateTimeStr)!
}
