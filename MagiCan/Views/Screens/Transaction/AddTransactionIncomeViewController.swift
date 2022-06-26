//
//  AddTransactionIncomeViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit
import Combine

class AddTransactionIncomeViewController: UIViewController {

    private lazy var contentView = AddTransactionIncomeView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
