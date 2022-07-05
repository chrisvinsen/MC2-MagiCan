//
//  RegisterPINViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 19/06/22.
//

import UIKit
import Combine

class RegisterPINViewController: UIViewController {

    private lazy var contentView = PINView(headingText: "Buat PIN", descriptionText: "PIN ini akan membantu akun kamu lebih aman dan terjaga.")
    
    var name, username: String
    var guestMenu = [Menu]()
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            let vc = RegisterConfirmPINViewController(name: name, username: username, pin: sender.text!)
            vc.guestMenu = self.guestMenu
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
