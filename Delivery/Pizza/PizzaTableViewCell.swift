import UIKit
import RealmSwift

class PizzaTableViewCell: UITableViewCell {
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var PizzaSizeButton: UISegmentedControl!
    @IBAction func AddButtonTap(_ sender: Any) {
    Persistance().addOrder()
    let product = Persistance.shared.getOrders()
        if let db = product.last {
        try! self.realm.write {
            db.ProductName = ProductName.text! + " \n\(String(Size)) cм"
            db.ProductImage = ProductImage.image!.pngData()!
            db.Price = Price.text!
        }}
        ColorButton(buttom: self.AddButton)
    }
    
    private let realm = try! Realm()
    private var basket: Results<BasketRealm>!
    
    private var Size = 26
    @IBAction func PizzaSize(_ sender: Any) {
        switch self.PizzaSizeButton.selectedSegmentIndex {
        case 0: Size = 26
        case 1: Size = 30
        case 2: Size = 40
        default: break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.AddButton.layer.cornerRadius = AddButton.frame.width / 2
        self.AddButton.backgroundColor = #colorLiteral(red: 0, green: 0.4993750453, blue: 1, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
