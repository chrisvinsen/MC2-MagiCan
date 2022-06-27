//
//  PrediksiJumlahMenuTable.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 24/06/22.
//

import UIKit

class PrediksiJumlahMenuTable: UIViewController {

    let prediksiJumlahMenuTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(prediksiJumlahMenuTable)
        
        prediksiJumlahMenuTable.register(PrediksiJumlahMenuTableViewCell.self, forCellReuseIdentifier: PrediksiJumlahMenuTableViewCell.identifier)
        prediksiJumlahMenuTable.delegate = self
        prediksiJumlahMenuTable.dataSource = self
        
        self.title = "Riwayat Transaksi"
        
        setUpConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        prediksiJumlahMenuTable.frame = view.bounds
    }
    
    private func setUpConstraints() {
        
    }
}

extension PrediksiJumlahMenuTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prediksiJumlahMenuTable.dequeueReusableCell(withIdentifier: PrediksiJumlahMenuTableViewCell.identifier, for: indexPath)
//        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prediksiJumlahMenuTable.deselectRow(at: indexPath, animated: false)
    }
}

extension PrediksiJumlahMenuTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PrediksiJumlahMenuTable_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            PrediksiJumlahMenuTable().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
