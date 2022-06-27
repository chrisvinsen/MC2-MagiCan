//
//  AddTransactionView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import Foundation
import UIKit

class AddTransactionView: UIView {
    
    var defaultSegmentedIndex: Int
    
    var segmentedControls = UISegmentedControl(items: ["Pemasukan", "Pengeluaran"])
    var viewContainer = UIView()
    
    init(defaultSegmentedIndex: Int = 0) {
        self.defaultSegmentedIndex = defaultSegmentedIndex
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        [segmentedControls, viewContainer]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        self.backgroundColor = .white
        
        segmentedControls.selectedSegmentIndex = defaultSegmentedIndex
    }
    
    func setUpConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            segmentedControls.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            segmentedControls.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            segmentedControls.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            viewContainer.topAnchor.constraint(equalTo: segmentedControls.bottomAnchor, constant: 20),
            viewContainer.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            viewContainer.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            viewContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AddTransactionView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            AddTransactionView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
