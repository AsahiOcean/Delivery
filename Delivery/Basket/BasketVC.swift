import UIKit
import RealmSwift

public var ToProfile: Bool = false
public var SeeOrderView: Bool = false

class BasketVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var OrderButton: UIButton!
    @IBOutlet weak var ProfileContainer: UIView!
    @IBOutlet weak var OrderStatus: UIView!
    @IBAction func Order(_ sender: UIButton) {
        if SeeOrderView == false {
        UIView.animate(withDuration: 0.5) {
            self.tableView.frame.origin.y += 200
        }
        self.OrderButton.setTitle("Оплачено", for: .normal)
        self.OrderButton.backgroundColor = .systemGreen
            print("Статус заказа виден")
            
        } else {
        UIView.animate(withDuration: 0.5) {
            self.tableView.frame.origin.y -= 200
        }
        print("Статус заказа не виден")
        }
    }
    
    
    @IBAction func ProfileButton(_ sender: UIButton) {
        if ToProfile == false {
            UIView.animate(withDuration: 0.5) {
                self.tableView.frame.origin.x -= self.view.frame.width
                self.OrderStatus.frame.origin.x = self.tableView.frame.origin.x
                print("Профиль виден")
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.tableView.frame.origin.x += self.view.frame.width
                self.OrderStatus.frame.origin.x = self.tableView.frame.origin.x
                print("Профиль не виден")
            }
        }
    }
    
    private let realm = try! Realm()
    private var basket: Results<BasketRealm>!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        self.OrderButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData(); self.sum()
    }
    
    private var total = 0
    private func sum() {
        let orders = Persistance.shared.getOrders()
        if orders.count > 0 {
            var sum = 0
            for i in 0...orders.count - 1 {
                sum += Int(orders[i].Price.dropLast(2))!
            }
            self.OrderButton.alpha = 1.0
            self.OrderButton.isEnabled = true
            self.OrderButton.backgroundColor = .systemBlue
            self.OrderButton.setTitle("К оплате \(sum) ₽", for: .normal)
            self.total = sum
        } else {
            self.OrderButton.alpha = 0.5
            self.OrderButton.isEnabled = false
            self.OrderButton.backgroundColor = .systemBlue
            self.OrderButton.setTitle("Заказов нет", for: .normal)
        }
    }
}

extension BasketVC: UITableViewDataSource, UITableViewDelegate, BasketTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let Orders = Persistance.shared.getOrders()
        return Orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell") as! BasketTableViewCell
        let Orders = Persistance.shared.getOrders()
        cell.ProductName.text = Orders[indexPath.row].ProductName
        cell.ProductImage.image = UIImage(data: Orders[indexPath.row].ProductImage)
        cell.Price.text = Orders[indexPath.row].Price
        // делегат для удаления ячейки
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func basketTableViewCell(_ bascketTableViewCell: BasketTableViewCell, indexPath: IndexPath) {
        Persistance.shared.removeOrder(index: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.reloadData(); self.sum()
    }
}
