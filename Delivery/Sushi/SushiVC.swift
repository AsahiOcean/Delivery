import UIKit
import SwiftyJSON

class SushiVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var Menu: [MenuSctruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LocalJSON(completition: { _ in })
        self.tableView.allowsSelection = false
    }
    
    fileprivate func LocalJSON(completition: @escaping ([MenuSctruct]) -> Void) {
        let json = try? JSON(data: Data(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!))
        for i in 0...json!["sushi"].count - 1 {
        self.Menu.append(MenuSctruct(
            name: (json!["sushi"][i]["name"].string)!,
            price: (json!["sushi"][i]["price"].int)!,
            description: json!["sushi"][i]["description"].arrayObject as? [String],
            imgName: json!["sushi"][i]["imgName"].string ?? "nosushi",
            weight: (json!["sushi"][i]["weight"].int)!))
        }
    }
}
extension SushiVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SushiTableViewCell") as! SushiTableViewCell
        cell.ProductName.text = Menu[indexPath.row].name
        cell.Description.text = "\(Menu[indexPath.row].description.flatMap{ $0 }!.joined(separator: ", "))"
        cell.Price.text = String(Menu[indexPath.row].price) + " ₽"
        cell.ProductImage.image = UIImage(named: Menu[indexPath.row].imgName)
        cell.Weight.text = String(Menu[indexPath.row].weight) + " гр"
        return cell
    }
}
