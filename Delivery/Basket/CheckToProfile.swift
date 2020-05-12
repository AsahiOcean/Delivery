import UIKit

class CheckToProfile: UIButton {
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                ToProfile = true
            } else {
                ToProfile = false
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
