//
//  OnboardingView.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 16/06/22.
//

import UIKit

class OnboardingView: UIViewController {
    
    let stackView = UIStackView()
        
    let imageView = UIImageView()
    let titleLabel = HeadingFiveLabel()
    let subtitleLabel = RegularLabel()
    
    init(image: UIImage, titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        
        imageView.image = image
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupLayout()
    }
}

extension OnboardingView {
    
    func setupStyle() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
        
    func setupLayout() {
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(30, after: stackView.subviews[0])
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(10, after: stackView.subviews[1])
        stackView.addArrangedSubview(subtitleLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.75),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            OnboardingView(
                image: OnboardingData.first.data.image,
                titleText: OnboardingData.first.data.title,
                subtitleText: OnboardingData.first.data.subtitle
            ).showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
