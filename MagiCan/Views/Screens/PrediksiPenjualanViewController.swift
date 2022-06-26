//
//  PrediksiPenjualanViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit

class PrediksiPenjualanViewController: UIViewController {

    let prediksiPenjualanView = PrediksiPenjualanView(status: true)
    
    override func loadView() {
        view = prediksiPenjualanView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prediksiPenjualanView.prediksiTable.dataSource = self
        prediksiPenjualanView.prediksiTable.delegate = self
        
        view.backgroundColor = .white
    }
}

extension PrediksiPenjualanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prediksiPenjualanView.prediksiTable.dequeueReusableCell(withIdentifier: PrediksiJumlahMenuTableViewCell.identifier, for: indexPath)
//        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prediksiPenjualanView.prediksiTable.deselectRow(at: indexPath, animated: false)
    }
}

extension PrediksiPenjualanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PrediksiPenjualanViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            PrediksiPenjualanViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
