//
//  CardTypeTwo.swift
//  MagiCan
//
//  Created by Nurul Srianda Putri on 20/06/22.
//

import Foundation
import UIKit

class DashboardPredictionSection: UIView {
    
    lazy var sectionLabel = SemiBoldLabel()
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct DashboardPredictionSection_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            DashboardPredictionSection().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
