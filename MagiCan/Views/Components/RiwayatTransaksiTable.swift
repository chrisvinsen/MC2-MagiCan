//
//  RiwayatTransaksiTable.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 24/06/22.
//

import UIKit

class RiwayatTransaksiTable: UIViewController {
    
    let riwayatTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(riwayatTable)
        
        riwayatTable.register(RiwayatTransaksiTableViewCell.self, forCellReuseIdentifier: RiwayatTransaksiTableViewCell.identifier)
        riwayatTable.delegate = self
        riwayatTable.dataSource = self
        
        self.title = "Riwayat Transaksi"
        
        setUpConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        riwayatTable.frame = view.bounds
    }
    
    private func setUpConstraints() {
        
    }
}

extension RiwayatTransaksiTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath)
//        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        riwayatTable.deselectRow(at: indexPath, animated: false)
    }
}

extension RiwayatTransaksiTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Riwayat Transaksi"
//    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct RiwayatTransaksiTable_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            RiwayatTransaksiTable().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
