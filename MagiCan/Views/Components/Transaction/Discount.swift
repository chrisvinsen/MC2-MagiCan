import UIKit

class Discount: UIButton {
    
    lazy var labelValue = UILabel()
    lazy var iconImage = UIImageView()
    lazy var divider = UIView()
    
    var label: String
    var value: String
    init(label: String = "Tambah Diskon", value: String = "Rp 0") {
    
        
        self.label = label
        self.value = value
        
        super.init(frame: .zero)
        
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        [divider, labelValue, iconImage]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setUpViews() {
        
        self.setTitle(label, for: .normal)
        self.contentHorizontalAlignment = .left
        self.titleLabel?.font = Font.textBold.getUIFont
        self.setTitleColor(UIColor.Neutral._90, for: .normal)
        
        labelValue.text = value
        labelValue.font = UIFont(name: "Inter-Bold", size: 14)
        labelValue.textColor = UIColor.Neutral._70
        
        let image = UIImage(systemName: "chevron.up")
        iconImage.image = image
        iconImage.tintColor = UIColor.Neutral._70
        
        divider.backgroundColor = UIColor.Neutral._50
        
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 50),
            
            iconImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            labelValue.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 122),
            labelValue.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: self.topAnchor),
            divider.leftAnchor.constraint(equalTo: self.leftAnchor),
            divider.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct Discount_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        Group {
            Discount().showPreview().previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
