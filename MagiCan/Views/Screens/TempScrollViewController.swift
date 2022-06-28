//
//  TempScrollViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 28/06/22.
//

import Foundation
import UIKit

class TempScrollViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = .red
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()

    private lazy var contentView: UIView = {
      let contentView = UIView()
      contentView.backgroundColor = .green
      contentView.translatesAutoresizingMaskIntoConstraints = false
      return contentView
    }()

    private lazy var stackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .leading
      stackView.spacing = 16
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
    }()
    
    override func viewDidLoad() {
      super.viewDidLoad()

      navigationItem.title = "Hello Scroll View!"

      configureSubviews()
      setupConstraints()
    }
    
    private func configureSubviews() {
      view.addSubview(scrollView)
      scrollView.addSubview(contentView)
      contentView.addSubview(stackView)

      for _ in 0..<10 {
        let view = UIView()
        view.backgroundColor = .blue
        stackView.addArrangedSubview(view)
      }
    }
    
    private func setupConstraints() {
      NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
      ])

      NSLayoutConstraint.activate([
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      ])

      NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
      ])

      for view in stackView.arrangedSubviews {
        NSLayoutConstraint.activate([
          view.widthAnchor.constraint(equalToConstant: 100),
          view.heightAnchor.constraint(equalToConstant: 100)
        ])
      }
    }
}
