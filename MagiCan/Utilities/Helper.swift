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
    return 0
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
