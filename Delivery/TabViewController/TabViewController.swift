import UIKit
import Tabman
import Pageboy
import RealmSwift

class TabViewController: TabmanViewController {
    
    var Category = ["  Пицца", "Суши", "Удон", "Поке", "Напитки", "Заказ   "]
    
    private(set) lazy var viewControllers: [UIViewController] = {
        return [
            self.boardID("PizzaVC"),
            self.boardID("SushiVC"),
            self.boardID("WokVC"),
            self.boardID("PokeVC"),
            self.boardID("DrinksVC"),
            self.boardID("BasketVC")]
    }()
    
    func boardID(_ name: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(name)")
    }
    
    private let realm = try! Realm()
    private var userinfo: Results<UserInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        addBar(bar, dataSource: self, at: .top)
        
        let userinfo = self.realm.objects(UserInfo.self)
        guard userinfo.count > 0 else {
            return Persistance().addUser()
        }
    }
}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = "\(Category[index])"
        return TMBarItem(title: title)
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
