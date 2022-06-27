//
//  DashboardViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit

struct CarouselData {
    let cardLabel: String
    let cardAmount: String
    let cardTime: String
    let cardIcon: String
    let cardColor: UIColor
}

class DashboardViewController: UIViewController {

    let dashboardView = DashboardView(status: false)
    
    var carouselData = [CarouselData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardView.carouselStatistik.carouselCollectionView.dataSource = self
        dashboardView.carouselStatistik.carouselCollectionView.delegate = self
        
        setup()
        setupStyle()
        setupLayout()
    }
}

extension DashboardViewController {
    func setup() {
        carouselData.append(.init(cardLabel: "Total Keuntungan", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 0/250, green: 196/255, blue: 154/255, alpha: 1)))
        carouselData.append(.init(cardLabel: "Total Pemasukan", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 22/250, green: 85/255, blue: 143/255, alpha: 1)))
        carouselData.append(.init(cardLabel: "Total Pengeluaran", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 235/250, green: 81/255, blue: 96/255, alpha: 1)))
        
        dashboardView.carouselStatistik.configureView(with: carouselData)
    }
    
    func setupStyle() {
        view.backgroundColor = .white
        dashboardView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayout() {
        view.addSubview(dashboardView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            dashboardView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            dashboardView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            dashboardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            dashboardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
}

extension DashboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return carouselData.count
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dashboardView.carouselStatistik.carouselCollectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as! CarouselCell
        
        let cardlabel = carouselData[indexPath.row].cardLabel
        let cardamount = carouselData[indexPath.row].cardAmount
        let cardtime = carouselData[indexPath.row].cardTime
        let cardicon = carouselData[indexPath.row].cardIcon
        let cardcolor = carouselData[indexPath.row].cardColor
        
//        let cardlabel = "aa"
//        let cardamount = "bb"
//        let cardtime = "cc"
//        let cardicon = "CarouselIcon.png"
        
        cell.configure(cardlabel: cardlabel, cardamount: cardamount, cardtime: cardtime, cardicon: cardicon, cardcolor:cardcolor)
        
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct DashboardViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            DashboardViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
