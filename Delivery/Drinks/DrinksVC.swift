import UIKit
import SwiftyJSON

class DrinksVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var Menu: [MenuSctruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.LocalJSON(completition: { _ in })
        self.tableView.allowsSelection = false
    }
    
    fileprivate func LocalJSON(completition: @escaping ([MenuSctruct]) -> Void) {
        let json = try? JSON(data: Data(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!))
        for i in 0...json!["drinks"].count - 1 {
        self.Menu.append(MenuSctruct(
        name: (json!["drinks"][i]["name"].string)!,
        price: (json!["drinks"][i]["price"].int)!,
        description: json!["drinks"][i]["description"].arrayObject as? [String],
        imgName: json!["drinks"][i]["imgName"].string ?? "nodrinks",
        weight: (json!["drinks"][i]["weight"].int)!))
        }
    }
}

extension DrinksVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinksTableViewCell") as! DrinksTableViewCell
        cell.ProductName.text = Menu[indexPath.row].name
        cell.Description.text = "\(Menu[indexPath.row].description.flatMap{ $0 }!.joined(separator: ", "))"
        cell.Price.text = String(Menu[indexPath.row].price) + " ₽"
        cell.ProductImage.image = UIImage(named: Menu[indexPath.row].imgName)
        cell.Weight.text = String(Menu[indexPath.row].weight) + " мл"
        return cell
    }
}
