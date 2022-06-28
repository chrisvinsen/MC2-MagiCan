//
//  DescriptionTextView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit

class DescriptionTextView: UIView {
    
    var currentCharacter = 0 {
        didSet {
            wordsCounterLabel.text =  "\(currentCharacter)"
        }
    }
    var maxCharacter = 200 {
        didSet {
            wordsMaxLabel.text = "/\(maxCharacter)"
        }
    }
    
    lazy var descriptionLabel = UILabel()
    lazy var wordsCounterLabel = UILabel()
    lazy var wordsMaxLabel = UILabel()
    lazy var textBox = UITextView() // NEED TO IMPLEMENT --> UITextViewDelegate
    
    init() {
        super.init(frame: .zero)
        
        textBox.delegate = self
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    private func addSubviews() {
        [descriptionLabel, wordsCounterLabel, wordsMaxLabel, textBox]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpViews() {
        descriptionLabel.text = "Deskripsi"
        wordsCounterLabel.text =  "\(currentCharacter)"
        wordsMaxLabel.text = "/\(maxCharacter)"
        
        textBox.autocorrectionType = .no
        textBox.text = "Opsional (maks. \(maxCharacter) karakter)"
        textBox.backgroundColor = UIColor.Neutral._30
        textBox.textColor = .secondaryLabel
        textBox.font = UIFont.preferredFont(forTextStyle: .body)
        textBox.layer.cornerRadius = 8
        textBox.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 150),
        
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            wordsMaxLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wordsMaxLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            wordsCounterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wordsCounterLabel.rightAnchor.constraint(equalTo: wordsMaxLabel.leftAnchor),
            
            textBox.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            textBox.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textBox.leftAnchor.constraint(equalTo: self.leftAnchor),
            textBox.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
}

extension DescriptionTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Remove the placeholder
        textView.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        currentCharacter = textView.text.count
        
        if currentCharacter >= maxCharacter {
            currentCharacter = maxCharacter
            
            textView.text = "\(textView.text.prefix(maxCharacter))"
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct DescriptionTextView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            DescriptionTextView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif

