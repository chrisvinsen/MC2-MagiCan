//
//  LongTextFieldView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 25/06/22.
//

import UIKit

class LongTextFieldView: UIView {
    
    lazy var descriptionLabel = UILabel()
    lazy var wordsCounterLabel = UILabel()
    lazy var wordsMaxLabel = UILabel()
    lazy var textBox = UITextView() // NEED TO IMPLEMENT --> UITextViewDelegate
    
    init() {
        super.init(frame: .zero)
        
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
        descriptionLabel.text = "Description"
        wordsCounterLabel.text =  "0"
        wordsMaxLabel.text = "/200"
        
        textBox.autocorrectionType = .no
        textBox.text = "Opsional (maks. 200 karakter)"
        textBox.backgroundColor = UIColor.Neutral._30
        textBox.textColor = .secondaryLabel
        textBox.font = UIFont.preferredFont(forTextStyle: .body)
        textBox.layer.cornerRadius = 8
        textBox.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        textView.placeholder = "Opsional (maks. 200 karakter)"
        
//        textField.updateStateDefault(){
//            descriptionBOx.layer.masksToBounds = false
//            descriptionBox.layer.shadowColor = UIColor.gray.cgColor
//            descriptionBox.layer.shadowOpacity = 0.2
//            descriptionBox.layer.shadowOffSet = CGSize(width: 0.5, height: 0.5)
//            descriptionBox.layer.shadowRadius = 10
//        }
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
        
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            wordsMaxLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wordsMaxLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            wordsCounterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wordsCounterLabel.rightAnchor.constraint(equalTo: wordsMaxLabel.leftAnchor),
            
            textBox.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            textBox.leftAnchor.constraint(equalTo: self.leftAnchor),
            textBox.rightAnchor.constraint(equalTo: self.rightAnchor),
            textBox.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct LongTextFieldView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            LongTextFieldView().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif

