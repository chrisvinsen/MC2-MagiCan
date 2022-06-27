//
//  General.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import UIKit

let ImageMenuDefault = UIImage(named: "DefaultImage.png")
let TransactionIncomeTypeData = [
    KeyValue(key: TransactionIncomeType.Offline.rawValue, value: "Offline (Tunai, Transfer QR, dll)", shortValue: "Offline"),
    KeyValue(key: TransactionIncomeType.Online.rawValue, value: "Online (Go Food, Grab Food, dll)", shortValue: "Online"),
]
let TransactionExpenseTypeData = [
    KeyValue(key: TransactionExpenseType.Usaha.rawValue, value: "Usaha", shortValue: "Usaha"),
    KeyValue(key: TransactionExpenseType.Pribadi.rawValue, value: "Pribadi", shortValue: "Pribadi"),
]

struct KeyValue {
    var key: Any
    var value: Any
    var shortValue: Any
    var status: Bool = false
}

enum TransactionCategory: Int {
    case Income = 1
    case Expense = 2
}

enum TransactionIncomeType: Int {
    case UpdateBalance = 1
    case Offline = 2
    case Online = 3
}

enum TransactionExpenseType: Int {
    case UpdateBalance = 1
    case Usaha = 2
    case Pribadi = 3
}
