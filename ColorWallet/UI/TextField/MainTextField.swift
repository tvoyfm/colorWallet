import UIKit

class MainTextField: UITextField {
    override init(frame:CGRect) {
        super.init(frame:frame)
        layer.cornerRadius = 15
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
