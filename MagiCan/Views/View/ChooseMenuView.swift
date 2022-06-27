//
//  ChooseMenuView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 27/06/22.
//

import Foundation
import UIKit

class ChooseMenuView: UIView {
    
    lazy var tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        self.addSubview(tableView)
    }
    
    func setUpViews() {
        
        self.backgroundColor = .white
        
        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChecklistCell.self, forCellReuseIdentifier: "ChecklistCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.Neutral._50.cgColor
    }
    
    func setUpConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ChooseMenuView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            ChooseMenuView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
