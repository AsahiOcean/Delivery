import UIKit
import RealmSwift

class BasketTableViewCell: UITableViewCell {
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBAction func DeleteProduct(_ sender: Any) {
        if let delegate = delegate,
        let indexPath = indexPath {
        delegate.basketTableViewCell(self, indexPath: indexPath)
        }
    }

    private let realm = try! Realm()
    private var basket: Results<BasketRealm>!

    var delegate: BasketTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DeleteButton.layer.cornerRadius = DeleteButton.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
protocol BasketTableViewCellDelegate: AnyObject {
    func basketTableViewCell(_ bascketTableViewCell: BasketTableViewCell, indexPath: IndexPath)
}
