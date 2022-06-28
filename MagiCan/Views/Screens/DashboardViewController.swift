//
//  DashboardViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit
import Combine

struct CarouselData {
    var cardLabel: String
    var cardAmount: String
    var cardTime: String
    var cardIcon: String
    var cardColor: UIColor
}

class DashboardViewController: UIViewController {
    
    let dashboardView = DashboardView(status: false)
    
    var carouselData = [CarouselData]()
    
    var userDetail: User?
    
    var kasAmount: Int64 = 3000 {
        didSet {
            self.dashboardView.cardKasUsaha.kasValue.text = self.kasAmount.formattedToRupiah
        }
    }
    
    var transactionLists = [Transaction]() {
        didSet {
            DispatchQueue.main.async{
                self.dashboardView.carouselStatistik.carouselCollectionView.reloadData()
//                print(self.transactionLists.count)
            }
        }
    }
    
    var totalIncome: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
//                print("SET SUMMARY")
                
                var keuntungan = self.totalIncome - self.totalExpense
                
                self.carouselData[0].cardAmount = keuntungan.formattedToRupiah
                self.carouselData[1].cardAmount = self.totalIncome.formattedToRupiah
                self.carouselData[2].cardAmount = self.totalExpense.formattedToRupiah
                
                if keuntungan < 0 {
                    self.carouselData[0].cardColor = UIColor(red: 224, green: 172, blue: 81, alpha: 1)
                }
                
                self.dashboardView.carouselStatistik.carouselCollectionView.reloadData()
            }
        }
    }
    var totalExpense: Int64 = 0 {
        didSet {
            
        }
    }
    
    private let viewModel: DashboardViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: DashboardViewModel = DashboardViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTransactionList()
        viewModel.getUserDetail()
        
        carouselData = [CarouselData]()
        
        carouselData.append(.init(cardLabel: "Total Keuntungan", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 0/250, green: 196/255, blue: 154/255, alpha: 1)))
        carouselData.append(.init(cardLabel: "Total Pemasukan", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 22/250, green: 85/255, blue: 143/255, alpha: 1)))
        carouselData.append(.init(cardLabel: "Total Pengeluaran", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 235/250, green: 81/255, blue: 96/255, alpha: 1)))
        
        dashboardView.carouselStatistik.configureView(with: carouselData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardView.carouselStatistik.carouselCollectionView.dataSource = self
        dashboardView.carouselStatistik.carouselCollectionView.delegate = self
        
        setUpTargets()
        setUpBindings()
        
        viewModel.getTransactionList()
        viewModel.getUserDetail()
        
        setupStyle()
        setupLayout()
    }
    
    private func setUpTargets() {
        dashboardView.cardKasUsaha.button.addTarget(self, action: #selector(cardKasUsahaButtonTapped(_ :)), for: .touchUpInside)
    }
    
    private func setUpBindings() {
        
        func bindViewModelToController() {
            viewModel.$transactionLists
                .assign(to: \.transactionLists, on: self)
                .store(in: &bindings)
            
            viewModel.$totalIncome
                .assign(to: \.totalIncome, on: self)
                .store(in: &bindings)
            
            viewModel.$totalExpense
                .assign(to: \.totalExpense, on: self)
                .store(in: &bindings)
            
            viewModel.$kasAmount
                .assign(to: \.kasAmount, on: self)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            // Completion after load data
            viewModel.resultUserDetail
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        print("FAILURE user detail")
                        return
                    case .finished:
                        print("FINISHED")
                        return
                    }
                } receiveValue: { [weak self] res in
//                    print(res)
                }
                .store(in: &bindings)
            
            viewModel.resultTransactions
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        print("FAILURE trasanction")
                        return
                    case .finished:
                        print("FINISHED")
                        return
                    }
                } receiveValue: { [weak self] res in
//                    print(res)
                }
                .store(in: &bindings)
        }
        
        bindViewModelToView()
        bindViewModelToController()
    }
    
}

extension DashboardViewController {
    func setup() {
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
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dashboardView.carouselStatistik.carouselCollectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as! CarouselCell
        
        let cardlabel = carouselData[indexPath.row].cardLabel
        let cardamount = carouselData[indexPath.row].cardAmount
        let cardtime = carouselData[indexPath.row].cardTime
        let cardicon = carouselData[indexPath.row].cardIcon
        let cardcolor = carouselData[indexPath.row].cardColor
        
        cell.configure(cardlabel: cardlabel, cardamount: cardamount, cardtime: cardtime, cardicon: cardicon, cardcolor:cardcolor)
        
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
}

extension DashboardViewController {
    @objc func cardKasUsahaButtonTapped(_ sender: UIButton) {
        let VC = KasUsahaModalViewController()
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
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
