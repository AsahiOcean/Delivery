import UIKit
import RealmSwift

class DrinksTableViewCell: UITableViewCell {
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var Weight: UILabel!
    @IBAction func AddButtonAction(_ sender: Any) {
    Persistance().addOrder()
        let product = Persistance.shared.getOrders()
        if let db = product.last {
        try! self.realm.write {
            db.ProductName = "\(ProductName.text!)"
            db.ProductImage = ProductImage.image!.pngData()!
            db.Price = Price.text!
        }}
        ColorButton(buttom: self.AddButton)
    }
    
    private let realm = try! Realm()
    private var basket: Results<BasketRealm>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.AddButton.layer.cornerRadius = AddButton.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
