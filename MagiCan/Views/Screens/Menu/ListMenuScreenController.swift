//
//  ListMenuScreenController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit

class ListMenuScreenController: UIViewController {
    
    let tableView = UITableView()
    let continueButton = PrimaryButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Daftar Menu"
        
        setupStyle()
        setupLayout()
        
        let VC = AddMenuScreenController()
        let navController = UINavigationController(rootViewController: VC)
        self.present(navController, animated: true, completion: nil)
    }
}

extension ListMenuScreenController {
    
    func setupStyle() {
        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Continue Button
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("Selanjutnya", for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_ :)), for: .touchUpInside)
    }
    
    func setupLayout() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(continueButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Table View
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            // Continue Button
            continueButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            continueButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - Actions
extension ListMenuScreenController {
    @objc func continueButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(LoginPINViewController(), animated: true)
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ListMenuScreenController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            ListMenuScreenController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
