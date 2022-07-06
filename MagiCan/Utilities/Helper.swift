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

func predictSalesNextWeek(transactionList: [Transaction]) -> Int {
//    print("di dalam prediksi -- transactionList mula-mula:", transactionList.count)
    
    var transactionListFiltered = transactionList.filter({ $0.category == TransactionCategory.Income.rawValue })
    
//    print("di dalam prediksi -- transactionList filtered:", transactionListFiltered.count)
    
    transactionListFiltered.indices.forEach {
        let date = transactionListFiltered[$0].date.components(separatedBy: "T")[0]
        transactionListFiltered[$0].date = date
    }
    
//    print("di dalam prediksi -- transactionList final:", transactionListFiltered)
    
    var dailySales = [Date: Double]()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    for transaction in transactionListFiltered {
        let date = dateFormatter.date(from: transaction.date)
        if let currentValue = dailySales[date!] {
            dailySales[date!] = currentValue + Double(transaction.amount)
        } else {
            dailySales[date!] = Double(transaction.amount)
        }
    }
    
//    print("di dalam prediksi -- daily sales:", dailySales)
    
    let sortedSales = dailySales.sorted { $0.key < $1.key }
    let dateArraySorted = Array(sortedSales.map({ $0.key }))
    let salesArraySorted = Array(sortedSales.map({ $0.value }))
    
//    print("di dalam prediksi -- date sorted:", dateArraySorted)
//    print("di dalam prediksi -- sales sorted:", salesArraySorted)
    
    let dayNumber = Array(stride(from: 0.0, through: 5.0, by: 1.0))
    
    let (slope, intercept) = getLinearRegressionCoefficient(x: dayNumber, y: salesArraySorted)
    
//    print("di dalam prediksi -- slope & intercept:", slope, intercept)
    
    let prediksi = Int(exactly: ((1+2+3+4+5+6+7) * slope + 7 * intercept).rounded())
    
    return prediksi!
}

// source: https://www.geeksforgeeks.org/linear-regression-python-implementation/
// source: https://victorqi.gitbooks.io/swift-algorithm/content/linear-regression.html
// x is the day number
// y is the total sales in each day
func getLinearRegressionCoefficient(x: [Double], y: [Double]) -> (slope: Double, intercept: Double) {
    let sum1 = average(multiply(y, x)) - average(x) * average(y)
    let sum2 = average(multiply(x, x)) - pow(average(x), 2)
    let slope = sum1 / sum2
    let intercept = average(y) - slope * average(x)
    
    return (slope, intercept)
}

func average(_ input: [Double]) -> Double {
    return input.reduce(0, +) / Double(input.count)
}

func multiply(_ a: [Double], _ b: [Double]) -> [Double] {
    return zip(a,b).map(*)
}


// source: https://stackoverflow.com/questions/35687411/how-do-i-find-the-beginning-of-the-week-from-an-nsdate
func getStartAndEndDateOfWeek() -> (startDate: Date, endDate:Date){
    
    let gregorian = Calendar(identifier: .gregorian)
    
    let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
    let startDate = gregorian.date(byAdding: .day, value: 2, to: sunday!)!
    let endDate = gregorian.date(byAdding: .day, value: 8, to: sunday!)!
    
    return (startDate, endDate)
}

func getStartAndEndDateOfLastWeek() -> (startDate: Date, endDate:Date){
    
    let gregorian = Calendar(identifier: .gregorian)
    
    let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
    let startDate = gregorian.date(byAdding: .day, value: -5, to: sunday!)!
    let endDate = gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    
    return (startDate, endDate)
}

func getStartAndEndDateWithRange(range: Int) -> (startDate: Date, endDate:Date){
    
    let gregorian = Calendar(identifier: .gregorian)
    
    let startDate = gregorian.date(byAdding: .day, value: -(range-1), to: Date())!
    let endDate = gregorian.date(byAdding: .day, value: 0, to: Date())!
    
    return (startDate, endDate)
}

func getDateString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    return dateFormatter.string(from: date)
}
