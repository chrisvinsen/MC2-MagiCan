//
//  StatistikPemasukanViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit

class StatistikPemasukanViewController: UIViewController {

    let statistikPemasukanView = StatistikPemasukanView(status: true)
    
    override func loadView() {
        view = statistikPemasukanView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statistikPemasukanView.riwayatTable.dataSource = self
        statistikPemasukanView.riwayatTable.delegate = self
        
        view.backgroundColor = .white
    }
}

extension StatistikPemasukanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("abc")
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statistikPemasukanView.riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath)
//        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statistikPemasukanView.riwayatTable.deselectRow(at: indexPath, animated: false)
    }
}

extension StatistikPemasukanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//extension StatistikPemasukanViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = statistikPemasukanView.riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath) as! RiwayatTransaksiTableViewCell
////        cell.textLabel?.text = "Cell \(indexPath.row)"
//        cell.transaksiId.text = "Pemasukan #0001"
//        cell.transaksiDate.text = "08 Juni 2022"
//        cell.transaksiCategory.text = "Offline"
//        cell.transaksiAmount.text = "+ Rp 100.000"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        statistikPemasukanView.riwayatTable.deselectRow(at: indexPath, animated: false)
//    }
//}
//
//extension StatistikPemasukanViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikPemasukanViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikPemasukanViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
