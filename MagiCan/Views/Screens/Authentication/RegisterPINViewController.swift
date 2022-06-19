//
//  RegisterPINViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import UIKit
import Combine

class RegisterPINViewController: UIViewController {

    private lazy var contentView = PINView(headingText: "Masukkan PIN Baru")
    
    var name: String = ""
    var username: String = ""
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Buat PIN"
        
        setUpTargets()
    }
    
    private func setUpTargets() {
        contentView.PINField.addTarget(self, action: #selector(PINFieldEdited(_ :)), for: .editingChanged)
    }
}

//MARK: - Actions
extension RegisterPINViewController {
    @objc func PINFieldEdited(_ sender: UITextField) {
        // Limit 6 PIN length
        sender.text = sender.text![0..<6]
        contentView.pin = sender.text!
        
        if sender.text!.count == 6 {
            let vc = RegisterConfirmPINViewController()
            vc.name = name
            vc.username = username
            vc.pin = sender.text!
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
