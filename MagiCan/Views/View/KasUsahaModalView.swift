//
//  KasUsahaModalView.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 29/06/22.
//

import UIKit

class KasUsahaModalView: UIView {

    lazy var modalTitle = UILabel()
    lazy var modalDescription = UILabel()
    lazy var kasEditField = UITextField()
    lazy var saveButton = UIButton(type: .system)
    lazy var cancelButton = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func addSubviews() {
        [modalTitle, modalDescription, kasEditField, saveButton, cancelButton]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        self.backgroundColor = UIColor(red: 242/250, green: 242/255, blue: 242/255, alpha: 0.8)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        modalTitle.text = "Set Kas Usaha"
        modalDescription.text = "Masukkan nilai nominal kas usaha awal"
        
        saveButton.setTitle("Batal", for: .normal)
        cancelButton.setTitle("Simpan", for: .normal)
        
//        saveButton.titleLabel?.textAlignment = .center
//        cancelButton.titleLabel?.textAlignment = .center
        
        kasEditField.backgroundColor = .white
        
//        cancelButton.frame.size = CGSize(width: self.frame.width/2, height: 40)
//        saveButton.frame.size = CGSize(width: self.frame.width/2, height: 40)
        
        cancelButton.backgroundColor = .green
        saveButton.backgroundColor = .red
    }
    
    private func setUpConstraints() {
//        let safeArea = safeAreaLayoutGuide
        
//        NSLayoutConstraint.activate([
////            self.widthAnchor.constraint(equalToConstant: 270),
////            self.heightAnchor.constraint(equalToConstant: 114),
//
//            modalTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
//            modalDescription.topAnchor.constraint(equalTo: modalTitle.bottomAnchor, constant: 5),
//
//            modalTitle.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
//            modalDescription.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
//
//            kasEditField.topAnchor.constraint(equalTo: modalDescription.bottomAnchor, constant: 5),
//            kasEditField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
//            kasEditField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
//
////            cancelButton.topAnchor.constraint(equalTo: kasEditField.bottomAnchor, constant: 10),
////            saveButton.topAnchor.constraint(equalTo: kasEditField.bottomAnchor, constant: 10),
//
//            cancelButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 10),
//            saveButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
//
//            cancelButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
//            saveButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10)
//        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct KasUsahaModalView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            KasUsahaModalView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
