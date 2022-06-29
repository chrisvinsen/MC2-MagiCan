//
//  GuestListMenuView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit

class GuestListMenuView: UIView {

    lazy var listMenuView = ListMenuView()
    lazy var nextButton = PrimaryButton()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        self.addSubview(listMenuView)
        self.addSubview(nextButton)
    }
    
    private func setUpViews() {
        
        self.backgroundColor = .white
        
        listMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Selanjutnya", for: .normal)
    }
    
    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            listMenuView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listMenuView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            listMenuView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            listMenuView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 10),
            nextButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct GuestListMenuView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            GuestListMenuView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
