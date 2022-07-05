//
//  RegisterSuccessViewController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 05/07/22.
//

import UIKit

class RegisterSuccessViewController: UIViewController {
    
    private lazy var contentView = RegisterSuccessView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
            let dashboardVC = UINavigationController(rootViewController: DashboardViewController())
            let transaksiVC = UINavigationController(rootViewController: TransactionListViewController())
            let listMenuVC = UINavigationController(rootViewController: ListMenuViewController())

            dashboardVC.tabBarItem = UITabBarItem(
                title: "Dashboard",
                image: UIImage(named: "icDashboard"),
                selectedImage: UIImage(named: "icDashboardActive")
            )
            transaksiVC.tabBarItem = UITabBarItem(
                title: "Transaksi",
                image: UIImage(named: "icTransaction"),
                selectedImage: UIImage(named: "icTransactionActive")
            )
            listMenuVC.tabBarItem = UITabBarItem(
                title: "Menu",
                image: UIImage(named: "icMenu"),
                selectedImage: UIImage(named: "icMenuActive")
            )
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [dashboardVC, transaksiVC, listMenuVC]
            tabBarController.modalPresentationStyle = .fullScreen
            
            self.present(tabBarController, animated: true)
        }
    }
}
