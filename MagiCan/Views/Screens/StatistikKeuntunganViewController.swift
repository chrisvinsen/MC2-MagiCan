//
//  StatistikKeuntunganViewController.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 26/06/22.
//

import UIKit

class StatistikKeuntunganViewController: UIViewController {

    let statistikKeuntunganView = StatistikKeuntunganView()
    
    override func loadView() {
        view = statistikKeuntunganView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statistikKeuntunganView.riwayatTable.dataSource = self
        statistikKeuntunganView.riwayatTable.delegate = self
        
        view.backgroundColor = .white
    }
}

extension StatistikKeuntunganViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statistikKeuntunganView.riwayatTable.dequeueReusableCell(withIdentifier: RiwayatTransaksiTableViewCell.identifier, for: indexPath)
//        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statistikKeuntunganView.riwayatTable.deselectRow(at: indexPath, animated: false)
    }
}

extension StatistikKeuntunganViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct StatistikKeuntunganViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            StatistikKeuntunganViewController().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
