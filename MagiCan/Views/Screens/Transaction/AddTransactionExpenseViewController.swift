//
//  AddTransactionExpenseViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit
import Combine

class AddTransactionExpenseViewController: UIViewController {

    private lazy var contentView = AddTransactionExpenseView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
