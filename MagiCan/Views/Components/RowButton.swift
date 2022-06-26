//
//  RowButton.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 26/06/22.
//

import UIKit

class RowButton: UIButton {
    
    init(label: String = "Default Label", value: String = "Default Value") {
        super.init(frame: .zero)
        
        self.setTitle(label, for: .normal)
        self.contentHorizontalAlignment = .left
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct RowButton_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            RowButton().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
