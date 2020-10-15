import UIKit

@IBDesignable
class AddMainButton: UIButton {
    
    var buttonColor     = Color.lightGray
    var buttonTintColor = Color.darkBlue
    var buttonFont      = UIFont(name: "Montserrat-Bold", size: 20)
    var cornerRadius:   CGFloat = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius  = cornerRadius
        backgroundColor     = buttonColor.uiColor
        titleLabel?.font    = buttonFont
        setTitleColor(.gray, for: .highlighted)
}

}
