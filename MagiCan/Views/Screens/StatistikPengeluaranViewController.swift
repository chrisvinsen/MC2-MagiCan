//
//  StatistikPengeluaranViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit

class StatistikPengeluaranViewController: UIViewController {

    let statistikPengeluaranView = StatistikPengeluaranView(status: true)
    
    override func loadView() {
        view = statistikPengeluaranView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statistikPengeluaranView.riwayatTable.dataSource = self
        statistikPengeluaranView.riwayatTable.delegate = self
        
        view.backgroundColor = .white
    }
}

extension StatistikPengeluaranViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statistikPengeluaranView.riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath)
//        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statistikPengeluaranView.riwayatTable.deselectRow(at: indexPath, animated: false)
    }
}

extension StatistikPengeluaranViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikPengeluaranViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikPengeluaranViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
