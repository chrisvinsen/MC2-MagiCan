//
//  AddTransactionViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit
import Combine

class AddTransactionViewController: UIViewController {
    
    let defaultSegmentedIndex = 0
    private lazy var contentView = AddTransactionView(defaultSegmentedIndex: defaultSegmentedIndex)
    private lazy var expenseViewController = AddTransactionExpenseViewController()
    private lazy var incomeViewController = AddTransactionIncomeViewController()
    
    var delegate: TransactionListViewDelegate!
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButtonItem = UIBarButtonItem(title: "Batal", style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.tintColor = UIColor.Primary._30
        navigationItem.leftBarButtonItem = leftBarButtonItem

        // Do any additional setup after loading the view.
        if defaultSegmentedIndex == 0 {
            add(asChildViewController: incomeViewController)
        } else if defaultSegmentedIndex == 1 {
            add(asChildViewController: expenseViewController)
        }
        
        setUpTargets()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate.reloadDataTable()
    }
    
    func setUpTargets() {
        
        contentView.segmentedControls.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
    }
}

// MARK: - Actions
extension AddTransactionViewController {
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        
        if sender.selectedSegmentIndex == 0 {
            remove(asChildViewController: expenseViewController)
            add(asChildViewController: incomeViewController)
        } else if sender.selectedSegmentIndex == 1 {
            remove(asChildViewController: incomeViewController)
            add(asChildViewController: expenseViewController)
        }
    }
    
}

// MARK: - Custom Functions
extension AddTransactionViewController {
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        contentView.viewContainer.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = contentView.viewContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }

    //----------------------------------------------------------------

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }

}

