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
    
    let dashboardView = DashboardView(statusPrediction: false, statusKas: false)
    
    var name: String = "" {
        didSet {
            var tempName = "Tamu"
            if name != "" {
                tempName = name;
            }
            
            dashboardView.welcomingHeader.name = self.name
            print("ini nama", name)
            
//            let label = UILabel()
//            label.font = Font.headingSix.getUIFont
//            label.textColor = UIColor.Neutral._90
//            label.text = "Selamat Datang, \(tempName)"
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        }
    }
    
    var carouselData = [CarouselData]()
    
    var userDetail: User?
    
    var kasAmount: Int64 = 0 {
        didSet {
            DispatchQueue.main.async{
                self.dashboardView.cardKasUsaha.kasIsSet = self.kasIsSet
                self.dashboardView.cardKasUsaha.kasValue.text = self.kasAmount.formattedToRupiah
//                if self.kasAmount != 0 {
//                    self.dashboardView.cardKasUsaha.kasIsSet = true
//                }
            }
        }
    }
    
    var kasIsSet: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.dashboardView.cardKasUsaha.kasIsSet = self.kasIsSet
                self.dashboardView.cardKasUsaha.kasValue.text = self.kasAmount.formattedToRupiah
            }
        }
    }
    
    var transactionLists = [Transaction]() {
        didSet {
            DispatchQueue.main.async{
                self.dashboardView.carouselStatistik.carouselCollectionView.reloadData()
            }
        }
    }
    
    var transactionListOneWeek = [Transaction]() {
        didSet {
            DispatchQueue.main.async{
                if self.transactionListOneWeek.count > 0 {
                    self.dashboardView.predictionAndMenuAvaiable = true
                }
            }
        }
    }
    
    var totalIncome: Int64 = 0 {
        didSet {
            DispatchQueue.main.async {
                
                var keuntungan = self.totalIncome - self.totalExpense
                
                self.carouselData[0].cardAmount = keuntungan.formattedToRupiah
                self.carouselData[1].cardAmount = self.totalIncome.formattedToRupiah
                self.carouselData[2].cardAmount = self.totalExpense.formattedToRupiah
                
                if keuntungan < 0 {
                    self.carouselData[0].cardColor = #colorLiteral(red: 0.9164255261, green: 0.6640771031, blue: 0.2302021682, alpha: 1)
                    self.carouselData[0].cardLabel = "Total Kerugian"
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
        
        let startDate = getDateString(date: getStartAndEndDateWithRange(range: 7).startDate)
        let endDate = getDateString(date: getStartAndEndDateWithRange(range: 7).endDate)
        viewModel.getTransactionList(startDate: startDate, endDate: endDate)
        viewModel.getUserDetail()
        
        carouselData = [CarouselData]()
        
        carouselData.append(.init(cardLabel: "Total Keuntungan", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 0/250, green: 196/255, blue: 154/255, alpha: 1)))
        carouselData.append(.init(cardLabel: "Total Pemasukan", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 22/250, green: 85/255, blue: 143/255, alpha: 1)))
        carouselData.append(.init(cardLabel: "Total Pengeluaran", cardAmount: "Rp 0", cardTime: "Minggu Ini", cardIcon:"CarouselIcon.png", cardColor: UIColor(red: 235/250, green: 81/255, blue: 96/255, alpha: 1)))
        
        dashboardView.carouselStatistik.configureView(with: carouselData)
        
        let x: [Double] = [1,2,3,4,5,6,7]
        let y: [Double] = [10,12,14,16,18,20,22]
        print("test helper linear regression:", getLinearRegressionCoefficient(x: x, y: y))
        
        print("test helper start & end date this week:", getStartAndEndDateOfWeek())
        print("test helper start & end date last week:", getStartAndEndDateOfLastWeek())
        print("test helper start & end date with range", getStartAndEndDateWithRange(range: 10))
        print("test helper func getDateString:", getDateString(date: getStartAndEndDateOfWeek().startDate))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardView.carouselStatistik.carouselCollectionView.dataSource = self
        dashboardView.carouselStatistik.carouselCollectionView.delegate = self
        
        setUpTargets()
        setUpBindings()
        
        let startDate = getDateString(date: getStartAndEndDateWithRange(range: 7).startDate)
        let endDate = getDateString(date: getStartAndEndDateWithRange(range: 7).endDate)
        viewModel.getTransactionList(startDate: startDate, endDate: endDate)
        viewModel.getUserDetail()
        
        setupStyle()
        setupLayout()
        
//        let icon = UIImage(systemName: "person.circle.fill")
//        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
//        let iconButton = UIButton(frame: iconSize)
//        iconButton.setBackgroundImage(icon, for: .normal)
//        let barButton = UIBarButtonItem(customView: iconButton)
//        iconButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)

//        self.navigationItem.rightBarButtonItem = barButton
    }
    
    private func setUpTargets() {
        dashboardView.welcomingHeader.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        dashboardView.cardKasUsaha.button.addTarget(self, action: #selector(cardKasUsahaButtonTapped(_ :)), for: .touchUpInside)
        dashboardView.cardKasUsaha.editButton.addTarget(self, action: #selector(cardKasUsahaEditButtonTapped(_ :)), for: .touchUpInside)
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
            
            viewModel.$initialCashSet
                .assign(to: \.kasIsSet, on: self)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            // Completion after load data
            viewModel.resultUserDetail
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] res in
                    self?.name = res.name
                }
                .store(in: &bindings)
            
            viewModel.resultTransactions
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(StatistikKeuntunganViewController(), animated: true)
        } else if indexPath.row == 1 {
            self.navigationController?.pushViewController(StatistikPemasukanViewController(), animated: true)
        } else {
            self.navigationController?.pushViewController(StatistikPengeluaranViewController(), animated: true)
        }
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
}

extension DashboardViewController {
    @objc func cardKasUsahaButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Atur Kas", message: "Masukkan nilai nominal kas awal", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = "Rp "
        }

        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: { [weak alert] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Simpan", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            self.viewModel.kasAmountEdit = textField?.text ?? "0"
            self.kasIsSet = true
//            self.viewModel.kasCreateTransaction = false
            self.viewModel.saveKasAmount()
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func cardKasUsahaEditButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Atur Kas", message: "Masukkan nilai nominal kas awal", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }

        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: { [weak alert] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Simpan", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            self.viewModel.kasAmountEdit = textField?.text ?? "0"
//            self.viewModel.kasCreateTransaction = true
            self.viewModel.saveKasAmount()
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func profileButtonTapped() {
        
        let VC = ProfileViewController()
        VC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(VC, animated: true)
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
