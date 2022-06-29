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
}

class GuestListMenuViewController: UIViewController {
    
    var name, username: String
    
    private lazy var contentView = GuestListMenuView()
    private lazy var emptyContentView = EmptyStateView(image: UIImage(named: "EmptyMenu.png")!, title: "Daftar Menu Belum Tersedia", desc: "Daftar menu kamu masih kosong. Klik tombol + diatas untuk menambah menu baru")
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var menuLists = [Menu]() {
        didSet {
            if menuLists.count > 0 {
                view = contentView
                
                DispatchQueue.main.async{
                    self.contentView.listMenuView.tableView.reloadData()
                }
            } else {
                view = emptyContentView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Daftar Menu"
        
        menuLists = []
        
        self.contentView.listMenuView.tableView.delegate = self
        self.contentView.listMenuView.tableView.dataSource = self
        
        let icon = UIImage(systemName: "plus.circle.fill")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 35, height: 35))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        iconButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        
        let barButton = UIBarButtonItem(customView: iconButton)
        

        navigationItem.rightBarButtonItem = barButton
        
        
        let VC = GuestAddMenuViewController()
        VC.delegate = self
        let navController = UINavigationController(rootViewController: VC)
        self.present(navController, animated: true, completion: nil)
        
        addTargets()
    }
    
    func addTargets() {
        contentView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
}

extension GuestListMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else {fatalError("Unable to create menu cell")}
        
        let thisMenu = menuLists[indexPath.row]
        var image = thisMenu.imageUrl?.imageFromBase64

        if image == nil {
            image = ImageMenuDefault
        }
        
        cell.menuImage.image = image
        cell.nameLabel.text = thisMenu.name
        cell.descriptionLabel.text = "@ \(thisMenu.price.formattedToRupiah)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Hapus") {
            (action, sourceView, completionHandler) in
            
            self.menuLists.remove(at: indexPath.row)

            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.Error._50
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        // Delete should not delete automatically
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
}

//MARK: - Action
extension GuestListMenuViewController {
    @objc func addButtonTapped() {
        let VC = GuestAddMenuViewController()
        VC.delegate = self
        let navController = UINavigationController(rootViewController: VC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func nextButtonTapped() {
        
        let VC = RegisterPINViewController(name: self.name, username: self.username)
        VC.guestMenu = menuLists
        
        navigationController?.pushViewController(VC, animated: true)
    }
}

extension GuestListMenuViewController: GuestListMenuDelegate {
    func addNewMenuData(newMenu: Menu) {
        self.menuLists.insert(newMenu, at: 0)
    }
}
