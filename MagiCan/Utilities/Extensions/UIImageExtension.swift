//
//  UIImageExtension.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import Foundation
import UIKit

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
