//
//  WelcomingAddMenuScreenController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit

class WelcomingAddMenuViewController: UIViewController {
    
    private lazy var contentView = WelcomingAddMenuView()
    
    var name: String
    var username: String
    
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
        let VC = GuestListMenuViewController(name: self.name, username: self.username)
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        let vc = DashboardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
