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
