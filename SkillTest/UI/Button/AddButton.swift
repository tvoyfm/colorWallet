import UIKit

@IBDesignable
class AddButton: UIButton {
    
    var buttonBackColor = UIColor.gray
    var buttonTintColor = Color.darkBlue
    var buttonFont = UIFont(name: "Montserrat-Bold", size: 20)
    var cornerRadius: CGFloat = 15
    
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
        
        backgroundColor     = buttonBackColor
        
        titleLabel?.font    = buttonFont
        
        setTitleColor(.lightGray, for: .highlighted)
        
        //addTarget(self, action: #selector(push), for: .touchUpInside)
}
    
    @objc func push(){
        print("pushed")
    }

}
