//
//  WelcomingAddMenuScreenController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit

class WelcomingAddMenuViewController: UIViewController {
    
    private lazy var contentView = WelcomingAddMenuView()
    
    var name: String = ""
    var username: String = ""
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Tambah Menu"
        
        setUpTargets()
    }
    
    private func setUpTargets() {
        contentView.addButton.addTarget(self, action: #selector(addButtonTapped(_ :)), for: .touchUpInside)
        contentView.skipButton.addTarget(self, action: #selector(skipButtonTapped(_ :)), for: .touchUpInside)
    }
}

//MARK: - Actions
extension WelcomingAddMenuViewController {
    @objc func addButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(GuestListMenuViewController(), animated: true)
    }
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        let vc = RegisterPINViewController()
        vc.name = name
        vc.username = username
        navigationController?.pushViewController(vc, animated: true)
    }
}
