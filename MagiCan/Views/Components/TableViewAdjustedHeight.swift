//
//  TableViewAdjustedHeight.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import Foundation
import UIKit

class TableViewAdjustedHeight: UITableView {
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
}
