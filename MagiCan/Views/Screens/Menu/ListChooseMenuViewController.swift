//
//  ListChooseMenuViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 29/06/22.
//

import UIKit
import Combine

class ListChooseMenuViewController: UIViewController {
        
    var isLargeTitle: Bool = true
//    var listMenuIdChosenBefore = [String]()

    var delegate: AddTransactionIncomeProtocol!

    private lazy var contentView = ListMenuView()
    private lazy var emptyContentView = EmptyStateView(image: UIImage(named: "EmptyMenu.png")!, title: "Daftar Menu Belum Tersedia", desc: "Daftar menu kamu masih kosong. Klik tombol + diatas untuk menambah menu baru")
    
    private let viewModel: ListMenuViewModel
    private var bindings = Set<AnyCancellable>()
    
    var cellViewModel = MenuCellViewModel()
    
    var menuLists = [Menu]() {
        didSet {
            
            if searchText != "" {
                self.filteredMenuLists = self.menuLists.filter { $0.name.lowercased().contains(searchText) }
            } else {
                self.filteredMenuLists = self.menuLists
            }
            
            DispatchQueue.main.async{
                self.contentView.tableView.reloadData()
            }
        }
    }
    var filteredMenuLists = [Menu]() {
        didSet {
            
            if filteredMenuLists.count > 0 {
                view = contentView
            } else {
                view = emptyContentView
            }
        }
    }
    var searchText: String = ""
    
    let searchController = UISearchController()
    
    init(viewModel: ListMenuViewModel = ListMenuViewModel(), isLargeTitle: Bool = true) {
        self.viewModel = viewModel
        self.isLargeTitle = isLargeTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getMenuList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate.updateMenuChosen(menus: self.menuLists.filter { $0.isMenuChosen })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        title = "Menu"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let icon = UIImage(systemName: "plus.circle.fill")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        navigationItem.rightBarButtonItem = barButton
        
        
        let leftBarButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = UIColor.Primary._30
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        setUpTargets()
        setUpBindings()
        
//        viewModel.getMenuList()
    }
    
    private func setUpTargets() {
        
    }
    
    private func setUpBindings() {
//        func bindViewToViewModel() {
//            contentView.usernameField.textPublisher
//                .receive(on: DispatchQueue.main)
//                .assign(to: \.username, on: viewModel)
//                .store(in: &bindings)
//        }
        
        func bindViewModelToController() {
            viewModel.$menuLists
                .assign(to: \.menuLists, on: self)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            // Completion after load data
            viewModel.result
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] res in
                    print(res)
                }
                .store(in: &bindings)
            
            // Completion after delete data
            viewModel.deleteResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] message in
                    
                }
                .store(in: &bindings)
            
            cellViewModel.cellResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        // Error can be handled here (e.g. alert)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] menuImage in
                    
                    if menuImage.imageUrl == "" {
                        return
                    }
                    
                    if let idx = self?.viewModel.menuLists.firstIndex(where: { $0._id == menuImage.menu_id }) {
                        
                        self?.viewModel.menuLists[idx].imageUrl = menuImage.imageUrl
                    }
                }
                .store(in: &bindings)
        }
        
//        bindViewToViewModel()
        bindViewModelToView()
        bindViewModelToController()
    }
}

//MARK: - Action
extension ListChooseMenuViewController {
    @objc func addButtonTapped() {
        let VC = AddMenuViewController()
        VC.delegate = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
}

//MARK: - Table
extension ListChooseMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMenuLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else {fatalError("Unable to create menu cell")}
        
        let thisMenu = filteredMenuLists[indexPath.row]
        var image = thisMenu.imageUrl?.imageFromBase64
        
        if image == nil && !thisMenu.isLoadingImage {
            self.viewModel.menuLists[indexPath.row].isLoadingImage = true
            
            DispatchQueue(label: "menuCell\(indexPath.row)").async {
                self.cellViewModel.getMenuImage(menu_id: self.filteredMenuLists[indexPath.row]._id)
            }
        } else if image == nil {
            image = ImageMenuDefault
        }
        
        cell.isChecked = thisMenu.isMenuChosen
        cell.menuImage.image = image
        cell.nameLabel.text = filteredMenuLists[indexPath.row].name
        cell.descriptionLabel.text = "@ \(filteredMenuLists[indexPath.row].price.formattedToRupiah)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.viewModel.menuLists[indexPath.row].isMenuChosen = !self.viewModel.menuLists[indexPath.row].isMenuChosen
    }
}

//MARK: - List Menu Delegate
extension ListChooseMenuViewController: ListMenuDelegate {
    func reloadDataTable() {
        viewModel.getMenuList()
    }
    
    func addNewMenuData(newMenu: Menu) {
        viewModel.menuLists.insert(newMenu, at: 0)
    }
    
    func updateMenuData(newMenu: Menu) {
        
        if let idx = viewModel.menuLists.firstIndex(where: { $0._id == newMenu._id }) {
            
            viewModel.menuLists[idx] = newMenu
        }
    }
}

//MARK: - Search Bar
extension ListChooseMenuViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        searchText =  (searchController.searchBar.text ?? "").lowercased()
        
        if searchText == "" {
            filteredMenuLists = menuLists
        } else {
            filteredMenuLists = menuLists.filter { $0.name.lowercased().contains(searchText) }
        }
        
        DispatchQueue.main.async{
            self.contentView.tableView.reloadData()
        }
    }
}
