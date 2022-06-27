//
//  FormatterExtension.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation

extension Formatter {
     static let withSeparator: NumberFormatter = {
         let formatter = NumberFormatter()
         formatter.numberStyle = .decimal
         formatter.groupingSeparator = "."
         return formatter
     }()
 }
 
