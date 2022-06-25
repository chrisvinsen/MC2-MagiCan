//
//  ListMenuViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 24/06/22.
//

import UIKit
import Combine

protocol ListMenuDelegate {
    func reloadDataTable()
}

class ListMenuViewController: UIViewController {

    private lazy var contentView = ListMenuView()
    
    private let viewModel: ListMenuViewModel
    private var bindings = Set<AnyCancellable>()
    
    var menuLists = [Menu]() {
        didSet {
            print("DID SET")
            self.filteredMenuLists = self.menuLists
            DispatchQueue.main.async{
                self.contentView.tableView.reloadData()
            }
        }
    }
    var filteredMenuLists = [Menu]()
    
    let searchController = UISearchController()
    
    init(viewModel: ListMenuViewModel = ListMenuViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self

        view.backgroundColor = .white
        title = "Menu"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let icon = UIImage(systemName: "plus.circle.fill")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        navigationItem.rightBarButtonItem = barButton
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        setUpTargets()
        setUpBindings()
        
        viewModel.getMenuList()
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
                    
                    switch message {
                    case .empty:
                        return
                    case .starting:
                        return
                    case .procesing:
                        return
                    case .finish:
                        self?.reloadDataTable()
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
extension ListMenuViewController {
    @objc func addButtonTapped() {
        let VC = AddMenuViewController()
        VC.delegate = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
}

//MARK: - Table
extension ListMenuViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredMenuLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else {fatalError("Unable to create menu cell")}
        
        var image = filteredMenuLists[indexPath.row].imageUrl?.imageFromBase64
        if image == nil {
            image = UIImage(named: "SampleBakso.jpeg") //DEFAULT
        }
        cell.menuImage.image = image
        cell.nameLabel.text = filteredMenuLists[indexPath.row].name
        cell.descriptionLabel.text = "@ Rp \(filteredMenuLists[indexPath.row].price)"

        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Ubah") {
            (action, sourceView, completionHandler) in
            
            print("UBAH")

            completionHandler(true)
        }
        editAction.backgroundColor = UIColor.Secondary._50
        
        let deleteAction = UIContextualAction(style: .normal, title: "Hapus") {
            (action, sourceView, completionHandler) in
            
            self.viewModel.deleteMenu(idToDelete: self.filteredMenuLists[indexPath.row]._id)

            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.Error._50
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        // Delete should not delete automatically
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = EditMenuViewController(menu: filteredMenuLists[indexPath.row])
        VC.delegate = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
}

//MARK: - List Menu Delegate
extension ListMenuViewController: ListMenuDelegate {
    func reloadDataTable() {
        print("RELOAD PROTOCOL CALLED")
        viewModel.getMenuList()
    }
}

//MARK: - Search Bar
extension ListMenuViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText == "" {
            filteredMenuLists = menuLists
        } else {
            filteredMenuLists = menuLists.filter { $0.name.contains(searchText) }
        }
        
        DispatchQueue.main.async{
            self.contentView.tableView.reloadData()
        }
    }
}
