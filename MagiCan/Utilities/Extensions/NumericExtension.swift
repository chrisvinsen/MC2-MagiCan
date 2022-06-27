//
//  NumericExtension.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation

extension Numeric {
     var formattedToRupiah: String { "Rp \(Formatter.withSeparator.string(for: self) ?? "0")" }
}
