import Foundation
import UIKit

func ColorButton(buttom: UIButton!) {
    UIView.animate(withDuration: 0.25, animations: {
        buttom.backgroundColor = #colorLiteral(red: 0, green: 0.7847549229, blue: 0, alpha: 1)
    }, completion: { finished in
    UIView.animate(withDuration: 0.25, animations: {
        buttom.backgroundColor = #colorLiteral(red: 0, green: 0.4993750453, blue: 1, alpha: 1)
    })
    })
}
