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
        pageControl.currentPageIndicatorTintColor = .white
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
        [carouselCollectionView, pageControl]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }

    private func setUpViews() {
        self.backgroundColor = .clear
        carouselCollectionView.backgroundColor = .black
    }

    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            carouselCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            carouselCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            carouselCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            pageControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -10)
        ])
    }
}

//extension Carousel: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//          return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return carouselData.count
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as! CarouselCell
//        
////        let cardlabel = carouselData[indexPath.row].cardLabel
////        let cardamount = carouselData[indexPath.row].cardAmount
////        let cardtime = carouselData[indexPath.row].cardTime
////        let cardicon = carouselData[indexPath.row].cardIcon
//        
//        let cardlabel = "aa"
//        let cardamount = "bb"
//        let cardtime = "cc"
//        let cardicon = "CarouselIcon.png"
//        
//        cell.configure(cardlabel: cardlabel, cardamount: cardamount, cardtime: cardtime, cardicon: cardicon)
//        
//        return cell
//    }
//}
//
//extension Carousel: UICollectionViewDelegate {
//    
//}

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
