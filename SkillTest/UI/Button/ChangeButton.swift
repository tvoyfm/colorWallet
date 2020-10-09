import UIKit

@IBDesignable
class ChangeButton: UIButton {

    @IBInspectable var width: CGFloat = 50
    @IBInspectable var buttonColor: UIColor = .orange
    @IBInspectable var cornerRadius: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // task parameters
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width)
        ])
        layer.borderColor = buttonColor.cgColor
        layer.cornerRadius = cornerRadius
        
        // other
        layer.borderWidth = 1
        tintColor = buttonColor
    }
}
