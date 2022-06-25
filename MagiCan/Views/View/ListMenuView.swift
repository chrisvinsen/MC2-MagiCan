//
//  ListMenuView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 24/06/22.
//

import UIKit

class ListMenuView: UIView {

    lazy var tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        self.addSubview(tableView)
    }
    
    private func setUpViews() {
        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Table View
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ListMenuView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            ListMenuView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
