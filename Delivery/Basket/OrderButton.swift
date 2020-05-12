import UIKit

class OrderButton: UIButton {
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                SeeOrderView = true
            } else {
                SeeOrderView = false
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
