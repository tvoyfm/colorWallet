import UIKit

class MainTextField: UITextField {
    override init(frame:CGRect) {
        super.init(frame:frame)
        // layout
        layer.cornerRadius = 15
        // constraint
        translatesAutoresizingMaskIntoConstraints = false
        // add func
        addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapDone() {
        endEditing(true)
    }
}
