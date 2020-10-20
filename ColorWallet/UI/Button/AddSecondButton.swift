import UIKit

class AddSecondButton: UIButton {
    
    var buttonColor     = Color.lightGray
    var buttonTintColor = Color.darkBlue
    var buttonSize      = CGFloat(50)
    var buttonFont      = UIFont(name: "Montserrat-Bold", size: 35)
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
