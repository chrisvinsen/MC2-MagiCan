//
//  UITextFieldExtension.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 18/06/22.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
    
    func updateStateDefault() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        // Border Bottom
        var bottomBorder = UIView()
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.Neutral._50
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
    }
    
    func updateStateSuccess() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        // Border Bottom
        var bottomBorder = UIView()
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.Neutral._50
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        
        // Icon Success
        let icon = UIImageView()
        icon.image = UIImage(named: "icChecklist.png")
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(icon)
        icon.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(icon.frame.width) * -1).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func updateStateError() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        // Border Bottom
        var bottomBorder = UIView()
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.Error._30
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        
        // Icon Error
        let icon = UIImageView()
        icon.image = UIImage(named: "icError.png")
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(icon)
        icon.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(icon.frame.width) * -1).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
