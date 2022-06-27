//
//  GuestListMenuViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 17/06/22.
//

import UIKit
import Combine

protocol GuestListMenuDelegate {
    func addNewMenuData(newMenu: Menu)
    func updateMenuData(newMenu: Menu)
}

class GuestListMenuViewController: UIViewController {
    
    private lazy var contentView = GuestListMenuView()
    private let viewModel: GuestListMenuViewModel
    private var bindings = Set<AnyCancellable>()
    
    var menuLists = [Menu]() {
        didSet {
            DispatchQueue.main.async{
                self.contentView.listMenuView.tableView.reloadData()
            }
        }
    }
    
    init(viewModel: GuestListMenuViewModel = GuestListMenuViewModel()) {
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
        
        view.backgroundColor = .white
        title = "Masuk"
        
        self.contentView.listMenuView.tableView.delegate = self
        self.contentView.listMenuView.tableView.dataSource = self
        
        let icon = UIImage(systemName: "plus.circle.fill")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        navigationItem.rightBarButtonItem = barButton
        
        setUpBindings()
        
        let VC = GuestAddMenuViewController()
        let navController = UINavigationController(rootViewController: VC)
        self.present(navController, animated: true, completion: nil)
    }
    
    private func setUpBindings() {
//        func bindViewToViewModel() {
//            contentView.usernameField.textPublisher
//                .receive(on: DispatchQueue.main)
//                .assign(to: \.username, on: viewModel)
//                .store(in: &bindings)
//        }
//
//        func bindViewModelToView() {
//            viewModel.$isUsernameExists
//                .assign(to: \.isUsernameExists, on: contentView)
//                .store(in: &bindings)
//
//            viewModel.validationResult
//                .sink { completion in
//                    switch completion {
//                    case .failure:
//                        // Error can be handled here (e.g. alert)
//                        return
//                    case .finished:
//                        return
//                    }
//                } receiveValue: { [weak self] res in
//                    print(res)
//                }
//                .store(in: &bindings)
//
//        }
        
        func bindViewModelToController() {
            viewModel.$menuLists
                .assign(to: \.menuLists, on: self)
                .store(in: &bindings)
        }
        
//        bindViewToViewModel()
//        bindViewModelToView()
        bindViewModelToController()
    }
}

extension GuestListMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else {fatalError("Unable to create menu cell")}
//
//        let thisMenu = menuLists[indexPath.row]
//        var image = thisMenu.imageUrl?.imageFromBase64
//
//        if image == nil && !thisMenu.isLoadingImage {
//            self.viewModel.menuLists[indexPath.row].isLoadingImage = true
//
//            DispatchQueue(label: "menuCell\(indexPath.row)").async {
//                self.cellViewModel.getMenuImage(menu_id: menuLists[indexPath.row]._id)
//            }
//        } else if image == nil {
//            image = ImageMenuDefault
//        }
        
//        cell.menuImage.image = image
        cell.nameLabel.text = menuLists[indexPath.row].name
        cell.descriptionLabel.text = "@ Rp \(menuLists[indexPath.row].price)"

        return cell
    }
}

//MARK: - Action
extension GuestListMenuViewController {
    @objc func addButtonTapped() {
        let VC = GuestAddMenuViewController()
//        VC.delegate = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
}
