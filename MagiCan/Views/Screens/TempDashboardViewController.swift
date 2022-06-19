//
//  TempDashboardViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import UIKit

class TempDashboardViewController: UIViewController {
    
    let text = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "TEMPORARY DASHBOARD"
        text.textColor = .black
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        view.backgroundColor = .green
    }
}
