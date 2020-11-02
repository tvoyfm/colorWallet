import UIKit

class MainTextField: UITextField {
    
    var label           = UILabel()
    var labelText       = ""
    var labelHigh       = CGFloat(12.5)
    var labelFont       = UIFont(name: "Montserrat-Regular", size: 12.5)
    
    var corner          = CGFloat(15)
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(label: String, placeholderText: String) {
        self.init()
        labelText = label
        placeholder = placeholderText
        
        configTextField()
        configLabel()
    }
    
    func configTextField(){
        layer.cornerRadius = corner
        translatesAutoresizingMaskIntoConstraints = false
        addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
    }

    func configLabel(){
        label.text = labelText
        label.font = labelFont
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: labelHigh)
        ])
    }
    
    @objc func tapDone() {
        endEditing(true)
    }
}
