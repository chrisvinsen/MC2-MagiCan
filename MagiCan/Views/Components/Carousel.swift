//
//  Carousel.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 25/06/22.
//

import UIKit

class Carousel: UIView {

    lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
//        collection.dataSource = self
//        collection.delegate = self
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)
        collection.backgroundColor = .clear
        return collection
    } ()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
        return pageControl
    } ()
    
    var carouselData = [CarouselData]()
    var currentPage = 0
    
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
        [carouselCollectionView]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }

    private func setUpViews() {
        self.backgroundColor = .clear
    }

    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            carouselCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            carouselCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            carouselCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
//            pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 5),
//            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
//            pageControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
//            pageControl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ])
    }
}


extension Carousel {
    public func configureView(with data: [CarouselData]) {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 220, height: 112)
        carouselLayout.sectionInset = .zero
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        carouselData = data
        carouselCollectionView.reloadData()
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct Carousel_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            Carousel().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
